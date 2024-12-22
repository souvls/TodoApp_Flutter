import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:todolist_app/utils/helpers.dart';
import 'package:todolist_app/widgets/widgets.dart';

import '../providers/providers.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);

    return Row(
      children: [
        Expanded(
          child: CommomTextField(
            title: 'Date',
            hintText: Helpers.dateFormatter(date),
            readOnly: true,
            suffixicon: IconButton(
              onPressed: () => Helpers.selectDate(context, ref),
              icon: const FaIcon(FontAwesomeIcons.calendar),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommomTextField(
            title: 'Time',
            hintText: Helpers.timeToString(time),
            readOnly: true,
            suffixicon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}
