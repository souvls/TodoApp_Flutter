import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_app/utils/utils.dart';

final categoryProvider = StateProvider<TaskCategory>((ref) {
  return TaskCategory.others;
});
