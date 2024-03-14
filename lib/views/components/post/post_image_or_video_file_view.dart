import 'package:flutter/material.dart';
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/views/components/post/post_image_view.dart';
import 'package:saferent/views/components/post_video_view.dart';

class PostImageOrVideo extends StatelessWidget {
  final Post post;
  const PostImageOrVideo({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(post: post);

      case FileType.video:
        return PostVideoView(p: post);
      default:
        return const SizedBox();
    }
  }
}
