import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_app/data/data.dart';
import 'package:todolist_app/providers/task/tasks_provider.dart';
import 'package:todolist_app/utils/app_alerts.dart';
import 'package:todolist_app/utils/extension.dart';
import 'package:todolist_app/widgets/widgets.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks(
      {super.key, required this.tasks, this.isCompletedTasks = false});
  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emtryTaskMessage = isCompletedTasks
        ? 'There is no completed task yet'
        : 'there is no task to do';
    return ComomContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emtryTaskMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showAlertDeleteDialog(
                        context: context, ref: ref, task: task);
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return TaskDetail(task: task);
                        });
                  },
                  child: TaskTitle(
                      task: task,
                      onCompleted: (value) async {
                        await ref
                            .read(tasksProvider.notifier)
                            .updateTask(task)
                            .then((value) {
                          AppAlerts.displaySnackbar(
                              context,
                              task.isCompleted
                                  ? 'Task completed'
                                  : 'Task incompleted');
                        });
                      }),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
