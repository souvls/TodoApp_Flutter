import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist_app/utils/extension.dart';

class CommomTextField extends StatelessWidget {
  const CommomTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixicon,
    this.readOnly = false,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixicon;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),
        TextField(
          readOnly: readOnly,
          controller: controller,
          maxLines: maxLines,
          onTapOutside: (even) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration:
              InputDecoration(hintText: hintText, suffixIcon: suffixicon),
          onChanged: (value) {},
        )
      ],
    );
  }
}
