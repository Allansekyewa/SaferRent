import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/enums/date_sorting.dart';
import 'package:saferent/shoppingCart/models/cart_items.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';
import 'package:saferent/state/feedback/compact_feedback_column.dart';
import 'package:saferent/state/feedback/models/post_feedback_request.dart';
import 'package:saferent/state/feedback/providers/can_current_user_delete_post_provider.dart';
import 'package:saferent/state/feedback/providers/specific_post_with_feedback_provider.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/posts/providers/delete_post_provider.dart';
import 'package:saferent/state/viewership/views_count_view.dart';
import 'package:saferent/views/components/animations/small_error.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';
import 'package:saferent/views/components/dialogs/delete_dialog.dart';
import 'package:saferent/views/components/post/post_counts_view.dart';
import 'package:saferent/views/components/post/post_date_view.dart';
import 'package:saferent/views/components/post/post_display_message.dart';
import 'package:saferent/views/components/post/post_image_or_video_file_view.dart';
import 'package:saferent/views/components/view_buton.dart';
import 'package:saferent/views/post_feedback/post_feedback_view.dart';

import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestsForPostAndFeedback(
        postId: widget.post.postId,
        limit: 20,
        sortByCreatedAt: true,
        dateSorting: DateSorting.newestOnTop);
    //get actual post with its feedback
    final postWithFeedback = ref.watch(
      specificPostWithFeedbackProvider(
        request,
      ),
    );

    //can post be deleted
    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(
        widget.post,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Book Quick For A Quick Tour',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        centerTitle: false,
        actions: [
          const SizedBox(
            width: 10,
          ),
          //share button is always present
          postWithFeedback.when(
            data: (postWithFeedback) {
              return IconButton(
                onPressed: () {
                  final url = postWithFeedback.post.fileUrl;
                  Share.share(
                    url,
                    subject: Strings.check,
                  );
                },
                icon: const Icon(
                  CupertinoIcons.link,
                  size: 20,
                  color: Colors.purple,
                ),
              );
            },
            error: (error, stackTrace) {
              return const SmallErrorAnimation();
            },
            loading: () {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.green,
                  radius: 7,
                ),
              );
            },
          ),
          // delete button or no delete button if user cant delete this post
          if (canDeletePost.value ?? false)
            IconButton(
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                  titleOfObjectToDelete: Strings.delpO,
                ).present(context).then(
                      (shouldDelete) => shouldDelete ?? false,
                    );
                if (shouldDeletePost) {
                  await ref.read(deletePostProvider.notifier).deletePost(
                        post: widget.post,
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(
                CupertinoIcons.delete,
                color: Colors.red,
                size: 20,
              ),
            )
        ],
      ),
      body: postWithFeedback.when(
        data: (postWithFeedback) {
          final postId = postWithFeedback.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideo(post: postWithFeedback.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //viewbutton if post allows views
                    if (postWithFeedback.post.allowviews)
                      ViewsButton(postId: postId),
                    //feedback button if post allows feedback
                    if (postWithFeedback.post.allowfeedback)
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostFeedbackView(postId: postId),
                            ),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.purple,
                          size: 14,
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final cartProvidr = ref.read(cartProvider.notifier);
                        final myItem = CartItem(
                          description: 'Tour',
                          amount: 20000,
                          thumbnail: 'path/to/thumbnail',
                          postId: postId, // replace with actual thumbnail path
                          // replace with actual property ID
                        );
                        cartProvidr.addCartItem(myItem);
                      },
                      icon: const Icon(
                        CupertinoIcons.add_circled_solid,
                        size: 16,
                      ),
                      label: const Text(
                        'Book Tour At 20000ugx',
                        style: TextStyle(fontSize: 10, color: Colors.blue),
                      ),
                    ),

                    const Text("📞 0761439068",
                        style: TextStyle(fontSize: 10, color: Colors.red))
                  ],
                ),
                PostDateView(
                  dateTime: postWithFeedback.post.createdAt,
                ),
                //post details (show divider at the bottom)
                PostDisplayMessage(
                  post: postWithFeedback.post,
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Divider(
                    color: Colors.red,
                  ),
                ),
                if (postWithFeedback.post.allowviews)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ViewsCountView(postId: postId),
                      ],
                    ),
                  ),
                const Divider(color: Colors.red),
                const Text(
                  " Comments",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CompactFeedbackColumn(
                  feedbacks: postWithFeedback.feedbacks,
                ),
                // display feedback

                //add spacing from the bottom of the screen
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const SmallErrorAnimation();
        },
        loading: () {
          return const Text('');
        },
      ),
    );
  }
}
