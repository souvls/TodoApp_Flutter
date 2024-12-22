import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_app/data/repositories/task_repository_provider.dart';
import 'package:todolist_app/providers/task/task_notifier.dart';
import 'package:todolist_app/providers/task/task_state.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
