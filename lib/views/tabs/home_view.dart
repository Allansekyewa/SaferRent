import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/posts_view.dart';
import 'package:saferent/state/posts/providers/all_posts_provider.dart';
import 'package:saferent/views/components/animations/empty_animation_view.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);

    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsAnimationzwords(
              text: Strings.noSafeRENTSYet,
            );
          } else {
            // Convert Iterable to List and sort
            final sortedPosts = posts.toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return PostsGridView(
              posts: sortedPosts,
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
