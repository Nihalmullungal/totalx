import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/presentation/common/custom_text_field.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class ModalTextField extends StatelessWidget {
  const ModalTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final homebloc = BlocProvider.of<HomeScreenBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Name",
          style: FontTheme.hint,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          hint: "Enter name",
          cont: homebloc.namecont,
          hintStyle: FontTheme.hint,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Age",
          style: FontTheme.hint,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          hint: "Enter age",
          cont: homebloc.agecont,
          hintStyle: FontTheme.hint,
          keyboard: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
