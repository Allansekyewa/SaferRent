import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/user_info/providers/user_info_model_providers.dart';
import 'package:saferent/views/components/animations/error_animation_view.dart';
import 'package:saferent/views/components/rich_two_parts_text.dart';

class PostDisplayMessage extends ConsumerWidget {
  final Post post;
  const PostDisplayMessage({required this.post, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(
      post.userId,
    ));
    return userInfoModel.when(data: (userInfoModel) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTwoPartsText(
          leftPart: 'Unit Description',
          rightPart: post.description,
        ),
      );
    }, error: (error, stackTrace) {
      return const ErrorAnimation();
    }, loading: () {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    });
  }
}
