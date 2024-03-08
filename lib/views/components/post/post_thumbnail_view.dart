import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/posts/models/post.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:saferent/state/seenBy/models/seenBy_request.dart';
import 'package:saferent/state/seenBy/providers/seen_this_post_provider.dart';

class PostThumbNailView extends ConsumerWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbNailView(
      {Key? key, required this.post, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final userId = ref.read(userIdProvider);
        if (userId == null) {
          return;
        }
        final seenRequest = SeenByRequest(postId: post.postId, seenby: userId);
        final hasSeenState = ref.watch(seenThisPostProvider(seenRequest));
        bool hasSeen = false;

        if (hasSeenState is AsyncData<bool>) {
          hasSeen = hasSeenState.value;
        }

        if (!hasSeen) {
          onTapped();
        }
      },
      child: CachedNetworkImage(
        imageUrl: post.thumbnailUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(
          radius: 7,
          color: Colors.red,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.network_check),
      ),
    );
  }
}
