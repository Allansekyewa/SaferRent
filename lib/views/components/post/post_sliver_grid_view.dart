import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/seenBy/models/seen_count_view.dart';
import 'package:saferent/state/seenBy/models/seen_widget.dart';
import 'package:saferent/views/components/post/post_date_view.dart';
import 'package:saferent/views/components/post/post_details.dart';
import 'package:saferent/views/components/post/post_thumbnail_view.dart';

class PostSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostSliverGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final post = posts.elementAt(index);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsView(post: post),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: PostThumbNailView(
                          post: post,
                          onTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetailsView(post: post),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: SingleChildScrollView(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.doc_text_search,
                                      size: 12,
                                      color: Colors.purple,
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        post.description,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'posted: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                    flex: 1,
                                    child:
                                        PostDateView(dateTime: post.createdAt)),
                                const SizedBox(width: 10),
                                SeenWidget(postId: post.userId),
                                const SizedBox(width: 4),
                                SeenCountView(postId: post.postId),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}
