import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/providers/post_views_count_provider.dart';

class ViewsCountView extends ConsumerWidget {
  final PostId postId;
  const ViewsCountView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewsCount = ref.watch(
      postViewsCountProvider(
        postId,
      ),
    );
    return viewsCount.when(data: (int viewsCount) {
      final personOrPeople = viewsCount == 1 ? Strings.person : Strings.people;
      final viewsText = "$viewsCount $personOrPeople ${Strings.viewedTh} 😳";
      return Text(viewsText);
    }, error: (error, stackTrace) {
      return const ErrorAnimation();
    }, loading: () {
      return const CupertinoActivityIndicator();
    });
  }
}
