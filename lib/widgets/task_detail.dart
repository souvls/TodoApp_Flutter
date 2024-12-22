import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist_app/data/data.dart';
import 'package:todolist_app/utils/utils.dart';
import 'package:todolist_app/widgets/widgets.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final style = context.textTheme;
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CicleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          const Gap(16),
          Text(task.title,
              style: style.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(
            task.time,
            style: style.titleMedium,
          ),
          const Gap(16),
          Visibility(
              visible: !task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('task to be completed on ${task.time}'),
                  Icon(Icons.check_box, color: task.category.color),
                ],
              )),
          const Gap(16),
          Divider(
            thickness: 1.6,
            color: task.category.color,
          ),
          const Gap(16),
          Text(task.note.isEmpty ? 'There is no addition' : task.note),
          const Gap(16),
          Visibility(
              visible: task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('task to be completed on ${task.time}'),
                  const Icon(Icons.check_box, color: Colors.green),
                ],
              )),
        ],
      ),
    );
  }
}
