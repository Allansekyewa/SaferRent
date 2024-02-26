import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/notfiers/submit_landlord_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final submitLandlordProvider =
    StateNotifierProvider<SubmitLandlordNotifier, IsLoading>(
  (_) => SubmitLandlordNotifier(),
);
