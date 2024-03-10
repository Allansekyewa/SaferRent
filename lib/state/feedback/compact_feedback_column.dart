import 'package:flutter/material.dart';
import 'package:saferent/state/feedback/compact_feedback_tile.dart';
import 'package:saferent/state/feedback/models/feedback.dart';

class CompactFeedbackColumn extends StatelessWidget {
  final Iterable<FeedBack> feedbacks;
  const CompactFeedbackColumn({super.key, required this.feedbacks});

  @override
  Widget build(BuildContext context) {
    if (feedbacks.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: feedbacks
            .map(
              (feedbacks) => CompactFeedbackTile(feedbacks: feedbacks),
            )
            .toList(),
      ),
    );
  }
}
