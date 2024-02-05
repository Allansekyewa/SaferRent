import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/viewership/models/viewership_request.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/providers/has_viewed_post_provider.dart';
import 'package:saferent/views/providers/view_post_provider.dart';

class ViewsButton extends ConsumerWidget {
  final PostId postId;
  const ViewsButton({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasViewed = ref.watch(
      hasViewedPostProvider(postId),
    );
    return hasViewed.when(data: (hasViewed) {
      return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final viewershipRequest =
                ViewershipRequest(postId: postId, viewedby: userId);
            ref.read(viewedThisPostProvider(viewershipRequest));
          },
          icon: FaIcon(
            hasViewed ? CupertinoIcons.flag_fill : CupertinoIcons.flag,
            color: Colors.green,
            size: 14,
          ));
    }, error: (error, stacktrace) {
      return const ErrorAnimation();
    }, loading: () {
      return const Center(
        child: CupertinoActivityIndicator(
          color: Colors.black,
          radius: 7,
        ),
      );
    });
  }
}
