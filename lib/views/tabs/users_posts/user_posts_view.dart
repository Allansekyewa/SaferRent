import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/posts_view.dart';
import 'package:saferent/state/posts/providers/user_post_provider.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/animations/trying_animation_view.dart';
import 'package:saferent/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);

    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);

        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const AgentsAnimationzwords(
              text: Strings.agentsNo,
            );
          } else {
            return PostsGridView(posts: posts);
          }
        },
        loading: () => const CupertinoActivityIndicator(
          color: Colors.red,
          radius: 10,
        ),
        error: (_, __) => const ErrorAnimation(),
      ),
    );
  }
}
