import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist_app/data/data.dart';
import 'package:todolist_app/utils/extension.dart';
import 'package:todolist_app/widgets/widgets.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({super.key, required this.task, this.onCompleted});
  final Task task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    // final backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CicleContainer(
            color: task.category.color.withOpacity(iconOpacity),
            child: Center(
              child: Icon(
                task.category.icon,
                color: task.category.color.withOpacity(iconOpacity),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                      fontSize: 20,
                      fontWeight: fontWeight),
                ),
                Text(task.time)
              ],
            ),
          ),
          Checkbox(value: task.isCompleted, onChanged: onCompleted)
        ],
      ),
    );
  }
}
