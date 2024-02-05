import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';

import 'package:cached_network_image/cached_network_image.dart';

class PostThumbNailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbNailView(
      {Key? key, required this.post, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: CachedNetworkImage(
        imageUrl: post.thumbnailUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(
          radius: 7,
          color: Colors.red,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.network_check),
      ),
    );
  }
}
