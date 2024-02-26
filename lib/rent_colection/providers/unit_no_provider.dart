// Define a provider for the property unit list
import 'package:hooks_riverpod/hooks_riverpod.dart';

final unitNumbersProvider = StateProvider<List<String>>((ref) => []);
