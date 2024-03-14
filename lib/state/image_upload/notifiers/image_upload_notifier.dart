import 'dart:io' show File;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/constants/constants.dart';
import 'package:saferent/state/image_upload/exceptions/could_not_build_thumbnail.dart';
import 'package:saferent/state/image_upload/extensions/get_collection-name_from_file_type.dart';
import 'package:saferent/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';
import 'package:saferent/state/posts/models/post_payload.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set a(bool b) => state = b;
  Future<bool> c({
    required File d,
    required FileType e,
    required String f,
    required Map<PostSettings, bool> g,
    required UserId h,
  }) async {
    a = true;
    late Uint8List i;
    switch (e) {
      case FileType.image:
        final j = img.decodeImage(d.readAsBytesSync());
        if (j == null) {
          a = false;
          throw const CouldNotBuildThumbnailException();
        }
        final k = img.copyResize(
          j,
          width: Constants.imageThumbnailWidth,
        );
        final l = img.encodeJpg(k);
        i = Uint8List.fromList(l);
        break;
      case FileType.video:
        final m = await VideoThumbnail.thumbnailData(
            video: d.path,
            imageFormat: ImageFormat.JPEG,
            maxHeight: Constants.videoThumbnailMaxHeight,
            quality: Constants.videoThumbnailQuality);
        if (m == null) {
          a = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          i = m;
        }
        break;
    }
    final n = await i.getAspectRatio();
    final o = const Uuid().v4();
    final p = FirebaseStorage.instance
        .ref()
        .child(h)
        .child(FirebaseCollectionName.thumbnails)
        .child(o);
    final q = FirebaseStorage.instance
        .ref()
        .child(h)
        .child(e.collectionName)
        .child(o);
    try {
      final r = await p.putData(i);
      final s = r.ref.name;
      final t = await q.putFile(d);
      final u = t.ref.name;
      final v = PostPayLoad(
        userId: h,
        description: f,
        thumbnailurl: await p.getDownloadURL(),
        fileUrl: await q.getDownloadURL(),
        fileType: e,
        fileName: o,
        thumbnailStorageId: s,
        aspectRatio: n,
        originalFileStorageId: u,
        postSettings: g,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(v);
      return true;
    } catch (_) {
      return false;
    } finally {
      a = false;
    }
  }
}
