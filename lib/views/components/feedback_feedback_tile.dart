import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/feedback/providers/delete_feedback_provider.dart';
import 'package:saferent/state/user_info/providers/user_info_model_providers.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';
import 'package:saferent/views/components/dialogs/delete_dialog.dart';

class FeedBAckTileView extends ConsumerWidget {
  final FeedBack feedback;

  const FeedBAckTileView({required this.feedback, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(feedback.fromUserId),
    );
    return userInfo.when(data: (userInfo) {
      final currentUserId = ref.read(userIdProvider);
      return ListTile(
        trailing: currentUserId == feedback.fromUserId
            ? IconButton(
                onPressed: () async {
                  final shouldDeleteFeedback =
                      await displayDeleteDialog(context);
                  if (shouldDeleteFeedback) {
                    await ref
                        .read(deleteFeedbackProvider.notifier)
                        .deleteFeedback(feedbackId: feedback.id);
                  }
                },
                icon: const Icon(
                  CupertinoIcons.bin_xmark_fill,
                  color: Color(0xFFFFD600),
                  size: 15,
                ),
              )
            : null,
        title: Text(
          userInfo.displayName,
          style: const TextStyle(fontSize: 12, color: Colors.red),
        ),
        subtitle: Text(
          feedback.feedback,
          style: const TextStyle(color: Colors.purple, fontSize: 10),
        ),
      );
    }, error: ((error, stackTrace) {
      return const ErrorAnimation();
    }), loading: () {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    });
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.feedback)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
