import 'package:flutter/material.dart';
import 'package:totalx/presentation/common/font_theme.dart';

customSnackBar(BuildContext ctx, String message, bool isSuccess) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: (MediaQuery.of(ctx).size.height -
                  MediaQuery.of(ctx).viewInsets.bottom) -
              160,
          left: 10,
          right: 10),
      content: Text(
        message,
        style: FontTheme.subHeading,
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
}
