import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/image_upload/models/thumbnail_request.dart';
import 'package:saferent/views/components/animations/small_error.dart';

import '../../../state/image_upload/providers/thumbnail_providers.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    Key? key,
    required this.thumbnailRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(thumbnailRequest),
    );
    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      loading: () {
        return const CupertinoActivityIndicator();
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimation();
      },
    );
  }
}
