import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/posts_view.dart';
import 'package:saferent/state/posts/providers/all_posts_provider.dart';
import 'package:saferent/views/components/animations/empty_animation_view.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? k}) : super(key: k);

  @override
  Widget build(BuildContext context, WidgetRef rf) {
    final p = rf.watch(allPostsProvider);

    return RefreshIndicator(
      onRefresh: () {
        rf.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: p.when(
        data: (px) {
          if (px.isEmpty) {
            return const EmptyContentsAnimationzwords(
              text: Strings.noSafeRENTSYet,
            );
          } else {
            // Convert Iterable to List and sort
            final sPs = px.toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return PostsGridView(
              p1x: sPs,
            );
          }
        },
        error: (_, __) {
          // Displaying the error message in the UI
          return const ErrorAnimation();
        },
        loading: () {
          return const CupertinoActivityIndicator(
            color: Colors.red,
            radius: 7,
          );
        },
      ),
    );
  }
}
