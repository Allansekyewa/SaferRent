import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/providers/provide_by_term_search_provider.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/animations/search_empty_view.dart';
import 'package:saferent/views/components/post/post_sliver_grid_view.dart';
import 'package:saferent/views/constants/strings.dart';

import 'animations/search_animation_view.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({required this.searchTerm, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: SearchAnimationViewWithWords(text: Strings.searchK),
      );
    }
    final posts = ref.watch(
      postsBysearchTermProvider(searchTerm),
    );
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
              child: SearchEmptyWithWords(
            text: Strings.noSearch,
          ));
        } else {
          return PostSliverGridView(posts: posts);
        }
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: ErrorAnimation(),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
              radius: 6,
            ),
          ),
        );
      },
    );
  }
}
