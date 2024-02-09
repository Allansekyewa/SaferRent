import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewsModel extends StateNotifier<Map<String, Set<String>>> {
  UserViewsModel() : super({});

  void viewPost(String userId, String postId) {
    if (!state.containsKey(postId)) {
      state[postId] = {};
    }

    if (state[postId] != null && !state[postId]!.contains(userId)) {
      state[postId]!.add(userId);
      state = {...state};
    }
  }

  int getViewCount(String postId) => state[postId]?.length ?? 0;
}
