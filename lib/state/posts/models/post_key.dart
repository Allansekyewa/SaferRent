import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostKey {
  static const userId = 'uid';
  static const feedback = 'feedback';
  static const createdAt = 'created_at';
  static const description = 'description';
  static const thumbnailUrl = 'thumbnail_url';
  static const fileType = 'file_type';
  static const fileName = 'file_name';
  static const fileUrl = 'file_url';
  static const aspectRatio = 'aspect_ratio';
  static const postSettings = 'post_settings';
  static const thumbnailStorageId = 'thumbnail_storage_id';
  static const originalFileStorageId = 'original_file_storage_id';
  static const postLocaton = 'location';
  static const postPrice = 'price';

  const PostKey._();
}
