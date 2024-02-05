import 'package:saferent/enums/date_sorting.dart';
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/feedback/models/post_feedback_request.dart';

extension Sorting on Iterable<FeedBack> {
  Iterable<FeedBack> applySortingFrom(RequestsForPostAndFeedback request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
