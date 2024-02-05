import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  static const feedbackTitle = 'Allow Comments';
  static const noFeed = 'Be the first to comment';
  static const feedbackWrite = 'Write Comments about this SafeRent here👇';
  static const feedbackDes =
      'By triggering Comments users will be able to send Feedback about that SafeRent';
  static const allowFeedbackStorageKey = 'allow Feedback';
  static const viewTitle = 'Allow Flags';
  static const viewDes =
      'Trigger this to allow SafeRents to track how many people appreciated your Work on the SafeRents';
  static const allowViewsStorageKey = 'allow views';
  static const agentFormSubmit =
      'Your Form Has Been Submitted Successfully Awaiting Atttestation';
  const Constants._();
}
