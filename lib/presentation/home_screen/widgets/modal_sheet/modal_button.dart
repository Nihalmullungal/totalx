import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_event.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/presentation/common/custom_snackbar.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class ModalButton extends StatelessWidget {
  const ModalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homec = BlocProvider.of<HomeScreenBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              homec.clearAllField();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: const Color.fromRGBO(229, 229, 229, 1)),
            child: Text(
              "cancel",
              style: FontTheme.cancelModal,
            )),
        const SizedBox(
          width: 10,
        ),
        BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is NameFieldErrorState) {
              customSnackBar(context, "Enter a valid Name", false, true);
            } else if (state is AgeFieldErrorState) {
              customSnackBar(context, "Enter a valid Age", false, true);
            } else if (state is ImageNotAddedState) {
              customSnackBar(context, "please a select a image", false, true);
            } else if (state is UploadDoneState) {
              customSnackBar(context, "user added successfully", true, true);
            }
          },
          builder: (context, state) {
            if (state is ModalLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ElevatedButton(
                onPressed: () async {
                  final bool result = await homec.checking();
                  if (result) {
                    homec.add(SaveClickedEvent());
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color.fromRGBO(23, 130, 255, 1)),
                child: Text(
                  "Save",
                  style: FontTheme.saveModal,
                ));
          },
        ),
      ],
    );
  }
}
