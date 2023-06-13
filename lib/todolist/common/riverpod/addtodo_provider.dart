import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
final todoProvider = StateProvider<String>(
  (ref) => "todo",
);
final reference = StateProvider<List>((ref) => []);
