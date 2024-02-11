import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/views/components/post/post_details.dart';
import 'package:saferent/views/components/post/post_thumbnail_view.dart';

class PostSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 0.0, crossAxisSpacing: 0.0),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbNailView(
            post: post,
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsView(post: post),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
