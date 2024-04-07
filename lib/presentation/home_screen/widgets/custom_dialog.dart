import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_event.dart';
import 'package:totalx/presentation/common/font_theme.dart';

customDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Are you sure to logout?",
          style: FontTheme.headingUser,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(LogoutClickedEvent());
              },
              child: Row(
                children: [
                  Text(
                    "Yes",
                    style: FontTheme.logout,
                  ),
                  const Icon(
                    Icons.done,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Text(
                      "No",
                      style: FontTheme.timerStyle,
                    ),
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    )
                  ],
                )),
          ],
        ),
      );
    },
  );
}
