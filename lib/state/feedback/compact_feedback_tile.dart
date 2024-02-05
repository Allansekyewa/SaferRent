import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/user_info/providers/user_info_model_providers.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/rich_two_parts_text.dart';

class CompactFeedbackTile extends ConsumerWidget {
  final FeedBack feedbacks;
  const CompactFeedbackTile({required this.feedbacks, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(
      feedbacks.fromUserId,
    ));
    return userInfo.when(data: (userInfo) {
      return RichTwoPartsText(
        leftPart: userInfo.displayName,
        rightPart: feedbacks.feedback,
      );
    }, error: (error, stacktrace) {
      return const ErrorAnimation();
    }, loading: () {
      return const CupertinoActivityIndicator(
        color: Colors.black,
        radius: 7,
      );
    });
  }
}
