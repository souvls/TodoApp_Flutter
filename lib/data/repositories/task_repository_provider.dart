import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_app/data/datasource/datasource_provider.dart';
import 'package:todolist_app/data/repositories/task_repository.dart';
import 'package:todolist_app/data/repositories/task_repository_impl.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.read(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});
