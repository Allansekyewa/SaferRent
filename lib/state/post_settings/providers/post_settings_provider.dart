import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/post_settings/models/post_settings.dart';
import 'package:saferent/state/post_settings/notifiers/post_setting_notifiers.dart';

final postSettingProvider =
    StateNotifierProvider<PostStettingNotifier, Map<PostSettings, bool>>(
        (ref) => PostStettingNotifier());
