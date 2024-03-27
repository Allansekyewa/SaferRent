import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';

class PostStettingNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostStettingNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSettings.values) setting: true,
            },
          ),
        );
  void setSetting(
    PostSettings setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
