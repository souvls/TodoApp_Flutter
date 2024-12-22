import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/data/models/task.dart';
import 'package:todolist_app/providers/date_provider.dart';
import 'package:todolist_app/providers/task/task.dart';
import 'package:todolist_app/routes/routes.dart';
import 'package:todolist_app/utils/helpers.dart';
import 'package:todolist_app/utils/utils.dart';
import 'package:todolist_app/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(tasksProvider);
    final completedTasks = _compleatedTasks(taskState.tasks);
    final incompletedTasks = _incompleatedTasks(taskState.tasks);
    final selectDate = ref.watch(dateProvider);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Helpers.selectDate(context, ref),
                      child: DisplayWhiteText(
                        text: DateFormat.yMMMMd().format(selectDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Gap(10),
                    const DisplayWhiteText(
                      text: 'My Todo List',
                      fontSize: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: 170,
              left: 0,
              right: 0,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      DisplayListOfTasks(
                        tasks: incompletedTasks,
                      ),
                      const Gap(20),
                      Text(
                        'Completed',
                        style: context.textTheme.headlineMedium,
                      ),
                      const Gap(20),
                      DisplayListOfTasks(
                        tasks: completedTasks,
                      ),
                      const Gap(20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary),
                        onPressed: () => context.push(RouteLocation.createTask),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DisplayWhiteText(text: 'Add New Task'),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  List<Task> _compleatedTasks(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> _incompleatedTasks(List<Task> tasks) {
    return tasks.where((task) => !task.isCompleted).toList();
  }
}
