import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/presentation/common/font_theme.dart';

homeSortModal(BuildContext ctx) {
  return showBottomSheet(
    context: ctx,
    builder: (context) {
      return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (contex, state) {
          final homec = BlocProvider.of<HomeScreenBloc>(contex);
          return GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              color: Colors.black26,
              child: Column(
                  children: List.generate(3, (index) {
                return RadioListTile(
                    value: homec.sortingIndex == index ? true : false,
                    groupValue: true,
                    onChanged: (value) {});
              })),
            ),
          );
        },
      );
    },
  );
}
