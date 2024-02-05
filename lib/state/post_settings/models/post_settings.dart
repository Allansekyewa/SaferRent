import 'package:saferent/state/post_settings/constants/constants.dart';

enum PostSettings {
  allowFeedback(
      title: Constants.feedbackTitle,
      description: Constants.feedbackDes,
      storageKey: Constants.allowFeedbackStorageKey),
  allowViews(
      title: Constants.viewTitle,
      description: Constants.viewDes,
      storageKey: Constants.allowViewsStorageKey);

  final String title;
  final String description;
  final String storageKey;
  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
