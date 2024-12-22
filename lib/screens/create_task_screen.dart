import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/data/models/task.dart';
import 'package:todolist_app/providers/providers.dart';
import 'package:todolist_app/utils/app_alerts.dart';
import 'package:todolist_app/utils/extension.dart';
import 'package:todolist_app/utils/helpers.dart';
import 'package:todolist_app/widgets/select_date_time.dart';
import 'package:todolist_app/widgets/widgets.dart';

import '../providers/task/tasks_provider.dart';
import '../routes/route_location.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();

  const CreateTaskScreen({super.key});
  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
      ),
      // ignore: prefer_const_constructors
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommomTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              CommomTextField(
                title: 'Note',
                hintText: 'Note',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary),
                onPressed: _createTask,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(text: 'Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        date: DateFormat.yMMMd().format(date),
        time: Helpers.timeToString(time),
        category: category,
        isCompleted: false,
      );
      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task created successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Task title cannot be empty');
    }
  }
}
