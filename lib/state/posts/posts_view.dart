import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/seenBy/models/seen_count_view.dart';
import 'package:saferent/state/seenBy/models/seen_widget.dart';
import 'package:saferent/views/components/post/post_date_view.dart';
import 'package:saferent/views/components/post/post_details.dart';
import 'package:saferent/views/components/post/post_thumbnail_view.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> p1x;
  const PostsGridView({Key? key, required this.p1x}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(2.0),
      itemCount: p1x.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 4.0), // This adds space between posts
      itemBuilder: (context, index) {
        final post = p1x.elementAt(index);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailsView(
                  post: post,
                ),
              ),
            );
          },
          child: SizedBox(
            height: 90,

            // You can adjust this value as per your requirement
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                        0.5), // This adds space around the thumbnail
                    child: PostThumbNailView(
                      post: post,
                      onTapped: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsView(
                              post: post,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                        8.0), // This adds space around the description and date
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.maps_home_work_rounded,
                                size: 12,
                                color: Colors.pink,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                post.postLocation ?? "",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            const Icon(
                              Icons.payment_sharp,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              post.postPrice ?? "",
                              style: const TextStyle(fontSize: 10),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Posted: ',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.pink,
                                )),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                                flex: 1,
                                child: PostDateView(dateTime: post.createdAt)),
                            const SizedBox(
                              width: 7,
                            ),
                            SeenWidget(postId: post.userId),
                            const SizedBox(
                              width: 5,
                            ),
                            SeenCountView(postId: post.postId)
                          ],
                        ), // This adds space between the description and date
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
