import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/seenBy/providers/seen_by_count_provider.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';

class SeenCountView extends ConsumerWidget {
  final PostId postId;
  const SeenCountView({required this.postId, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seensCount = ref.watch(
      postSeensCountProvider(postId),
    );
    return seensCount.when(
      data: (int seensCount) {
        final seenText = '$seensCount';
        return Text(
          seenText,
          style: const TextStyle(fontSize: 10, color: Colors.black),
        );
      },
      error: (error, stackTrace) {
        return const ErrorAnimation();
      },
      loading: () {
        return const CupertinoActivityIndicator(
          radius: 6,
          color: Colors.red,
        );
      },
    );
  }
}
