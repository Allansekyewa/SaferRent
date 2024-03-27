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
    required this.fileToPost,
    required this.fileType,
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
    final priceController = useTextEditingController();
    final locController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FileThumbnailView(thumbnailRequest: thumbnailRequest),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: locController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Missing';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Locaton',
                    labelStyle: TextStyle(fontSize: 10),
                    hintText: "Enter Unit Location",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Missing';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Unit Price',
                    labelStyle: TextStyle(fontSize: 10),
                    hintText: "Enter Unit prices",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: Strings.portaDes,
                    suffixIcon: IconButton(
                      onPressed: isPostButtonEnabled.value
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                final userId = ref.read(userIdProvider);
                                if (userId == null) {
                                  return;
                                }
                                final description = postController.text;
                                final location = locController.text;
                                final prices = priceController.text;
                                final isUploaded = await ref
                                    .read(imageUploadProvider.notifier)
                                    .c(
                                        d: widget.fileToPost,
                                        e: widget.fileType,
                                        f: description,
                                        g: postSettings,
                                        h: userId,
                                        loc: location!,
                                        price: prices!);
                                if (isUploaded && mounted) {
                                  Navigator.of(context).pop();
                                  locController.clear();
                                  priceController.clear();
                                }
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
      ),
    );
  }
}
