import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';

import 'package:timeago/timeago.dart' as timeago;

class PostThumbNailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;

  const PostThumbNailView({
    Key? key,
    required this.post,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedTimeAgo = timeago.format(post.createdAt, locale: 'en_long');

    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 50, // Adjust the height as needed
          child: Column(
            children: [
              AspectRatio(
                aspectRatio:
                    10 / 9, // You can adjust this aspect ratio as needed
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(
                    radius: 10,
                    color: Colors.red,
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.network_check),
                ),
              ),
              const SizedBox(
                  height: 2), // Add spacing between the image and text
              Text(
                formattedTimeAgo,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
