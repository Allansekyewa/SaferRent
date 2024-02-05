import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';
import 'package:saferent/state/posts/models/post_key.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class PostPayLoad extends MapView<String, dynamic> {
  PostPayLoad(
      {required UserId userId,
      required String thumbnailurl,
      required String fileUrl,
      required FileType fileType,
      required String description,
      required String fileName,
      required String thumbnailStorageId,
      required double aspectRatio,
      required String originalFileStorageId,
      required Map<PostSettings, bool> postSettings})
      : super({
          PostKey.userId: userId,
          PostKey.aspectRatio: aspectRatio,
          PostKey.description: description,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileType.name,
          PostKey.fileName: fileName,
          PostKey.originalFileStorageId: originalFileStorageId,
          PostKey.thumbnailUrl: thumbnailurl,
          PostKey.postSettings: {
            for (final postSettings in postSettings.entries)
              postSettings.key.storageKey: postSettings.value
          }
        });
}
