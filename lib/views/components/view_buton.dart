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
  final PostId a;
  const ViewsButton({required this.a, super.key});

  @override
  Widget build(BuildContext b, WidgetRef c) {
    final d = c.watch(hasViewedPostProvider(a));
    return d.when(
        data: (e) {
          return IconButton(
            onPressed: () {
              final f = c.read(userIdProvider);
              if (f == null) return;
              final g = ViewershipRequest(postId: a, viewedby: f);
              c.read(viewedThisPostProvider(g));
            },
            icon: FaIcon(
              e ? CupertinoIcons.flag_fill : CupertinoIcons.flag,
              color: Colors.green,
              size: 14,
            ),
          );
        },
        error: (h, i) => const ErrorAnimation(),
        loading: () => const Center(
              child: CupertinoActivityIndicator(
                color: Colors.red,
                radius: 7,
              ),
            ));
  }
}
