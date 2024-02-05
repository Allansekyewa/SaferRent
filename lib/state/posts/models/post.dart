import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';
import 'package:saferent/state/posts/models/post_key.dart';

@immutable
class Post {
  final String postId;
  final String userId;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String description;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFilestorageId;
  final Map<PostSettings, bool> postSettings;
  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        description = json[PostKey.description],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFilestorageId = json[PostKey.originalFileStorageId],
        fileName = json[PostKey.fileName],
        fileType = FileType.values.firstWhere(
            (fileType) => fileType.name == json[PostKey.fileType],
            orElse: () => FileType.image),
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSettings.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        };
  bool get allowfeedback => postSettings[PostSettings.allowFeedback] ?? false;
  bool get allowviews => postSettings[PostSettings.allowViews] ?? false;
}
