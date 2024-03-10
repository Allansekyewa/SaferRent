import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/seenBy/providers/has_seen_post_provider.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';

class SeenWidget extends ConsumerWidget {
  final PostId postId;

  const SeenWidget({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasViewed = ref.watch(
      hasSeenPostProvider(postId),
    );

    return hasViewed.when(
      data: (hasViewed) {
        return Icon(
          hasViewed ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          color: Colors.red,
          size: 14,
        );
      },
      error: (error, stacktrace) {
        return const ErrorAnimation();
      },
      loading: () {
        return const Center(
          child: CupertinoActivityIndicator(
            color: Colors.red,
            radius: 5,
          ),
        );
      },
    );
  }
}
