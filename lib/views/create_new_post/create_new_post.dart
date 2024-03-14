import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/image_upload/models/thumbnail_request.dart';
import 'package:saferent/state/image_upload/providers/image_uploader_provider.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';
import 'package:saferent/state/post_settings/providers/post_settings_provider.dart';

import 'package:saferent/views/components/post/thumbnail_view.dart';
import 'package:saferent/views/constants/strings.dart';

class CreateNewPost extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  const CreateNewPost({
    Key? key,
    required this.fileType,
    required this.fileToPost,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends ConsumerState<CreateNewPost> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest =
        ThumbnailRequest(file: widget.fileToPost, fileType: widget.fileType);
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isPostButtonEnabled.value = postController.text.isNotEmpty;
        }

        postController.addListener(listener);
        return () {
          postController.removeListener(listener);
        };
      },
      [postController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload to SafeRents',
          style: TextStyle(fontSize: 10, color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  labelText: Strings.portaDes,
                  suffixIcon: IconButton(
                    onPressed: isPostButtonEnabled.value
                        ? () async {
                            //get user id first
                            final userId = ref.read(userIdProvider);
                            if (userId == null) {
                              return;
                            }
                            final description = postController.text;
                            final isUploaded =
                                await ref.read(imageUploadProvider.notifier).c(
                                      d: widget.fileToPost,
                                      e: widget.fileType,
                                      f: description,
                                      g: postSettings,
                                      h: userId,
                                    );
                            if (isUploaded && mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        : null,
                    icon: const Icon(CupertinoIcons.cloud_upload_fill),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),

            //spread the postsettings values with help of(...)
            ...PostSettings.values.map(
              (postSetting) => ListTile(
                title: Text(
                  postSetting.title,
                  style: const TextStyle(
                      fontSize: 10, color: Colors.red, height: 1.5),
                ),
                subtitle: Text(
                  postSetting.description,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      wordSpacing: 0.5),
                ),
                trailing: Switch(
                  value: postSettings[postSetting] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingProvider.notifier).setSetting(
                          postSetting,
                          isOn,
                        );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
