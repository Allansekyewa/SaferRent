import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/views/components/post/post_date_view.dart';
import 'package:saferent/views/components/post/post_details.dart';
import 'package:saferent/views/components/post/post_thumbnail_view.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(1.0),
      itemCount: posts.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 5), // This adds space between posts
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
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
            height: 100, // You can adjust this value as per your requirement
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
                          child: SingleChildScrollView(
                            child: Row(children: <Widget>[
                              const Icon(
                                CupertinoIcons.map_pin_ellipse,
                                size: 10,
                                color: Colors.pink,
                              ), // Add CupertinoIcons.pin before description
                              const SizedBox(
                                  width:
                                      5), // Add some space between the icon and the description
                              Flexible(
                                child: Text(
                                  post.description,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            const Text('Posted: ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 10,
                            ),
                            PostDateView(dateTime: post.createdAt),
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
