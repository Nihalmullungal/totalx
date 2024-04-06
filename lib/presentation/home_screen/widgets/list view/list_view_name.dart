import 'package:flutter/material.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class ListViewName extends StatelessWidget {
  final String name;
  final int age;
  const ListViewName({super.key, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: FontTheme.heading,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Age:$age",
          style: FontTheme.age,
        ),
      ],
    );
  }
}
