import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/notifiers/payments_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final processPaymentProvider =
    StateNotifierProvider<ProcessPaymentNotifier, IsLoading>(
        (_) => ProcessPaymentNotifier());
