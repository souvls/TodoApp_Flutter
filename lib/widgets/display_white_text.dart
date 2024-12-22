import 'package:flutter/material.dart';
import 'package:todolist_app/utils/extension.dart';

class DisplayWhiteText extends StatelessWidget {
  const DisplayWhiteText(
      {super.key, required this.text, this.fontWeight, this.fontSize});
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
          color: context.colorScheme.surface,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: fontSize),
    );
  }
}
