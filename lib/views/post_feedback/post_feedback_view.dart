import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/feedback/models/post_feedback_request.dart';
import 'package:saferent/state/feedback/providers/post_feedback_provider.dart';
import 'package:saferent/state/feedback/providers/send_feedback_provider.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/animations/real_estate_view.dart';
import 'package:saferent/views/components/feedback_feedback_tile.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class PostFeedbackView extends HookConsumerWidget {
  final PostId postId;
  const PostFeedbackView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestsForPostAndFeedback(
        postId: postId,
      ),
    );
    final feedback = ref.watch(postFeedbackProvider(request.value));
    useEffect(() {
      feedbackController.addListener(() {
        hasText.value = feedbackController.text.isNotEmpty;
      });
      return () {};
    }, [feedbackController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      ),
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: feedback.when(data: (feedback) {
              if (feedback.isEmpty) {
                return const SingleChildScrollView(
                  child: RealEstateAnimationzwords(text: Strings.noFeedYet),
                );
              }

              return RefreshIndicator(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: feedback.length,
                    itemBuilder: (context, index) {
                      final feedbacks = feedback.elementAt(index);
                      return FeedBAckTileView(feedback: feedbacks);
                    },
                  ),
                  onRefresh: () {
                    ref.refresh(
                      postFeedbackProvider(
                        request.value,
                      ),
                    );
                    return Future.delayed(
                      const Duration(seconds: 1),
                    );
                  });
            }, error: (error, stackTrace) {
              return const ErrorAnimation();
            }, loading: () {
              return const CupertinoActivityIndicator(
                color: Colors.red,
                radius: 9,
              );
            }),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  textInputAction: TextInputAction.send,
                  controller: feedbackController,
                  onSubmitted: (feedback) {
                    if (feedback.isNotEmpty) {
                      _submitFeedbackWithController(feedbackController, ref);
                    }
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintMaxLines: null,
                      suffixIcon: IconButton(
                          onPressed: hasText.value
                              ? () {
                                  _submitFeedbackWithController(
                                    feedbackController,
                                    ref,
                                  );
                                }
                              : null,
                          icon: const Icon(
                            CupertinoIcons.cloud_upload_fill,
                          )),
                      labelText: Strings.writeFeedBack),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }

  Future<void> _submitFeedbackWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendFeedbackProvider.notifier).sendFeedback(
          fromUserId: userId,
          onPostId: postId,
          feedback: controller.text,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
