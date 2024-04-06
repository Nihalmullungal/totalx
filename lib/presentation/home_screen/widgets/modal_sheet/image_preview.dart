import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeScreenBloc>(context).imageSelector();
      },
      child: Center(
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            return BlocProvider.of<HomeScreenBloc>(context).selectedImage ==
                    null
                ? const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(
                        BlocProvider.of<HomeScreenBloc>(context)
                            .selectedImage
                            .toString())),
                  );
          },
        ),
      ),
    );
  }
}
