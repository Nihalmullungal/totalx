import 'package:flutter/material.dart';
import 'package:totalx/presentation/home_screen/widgets/modal_sheet/image_preview.dart';
import 'package:totalx/presentation/home_screen/widgets/modal_sheet/modal_button.dart';
import 'package:totalx/presentation/home_screen/widgets/modal_sheet/modal_text_field.dart';

Future<void> customModalSheet(
  context,
) async {
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    elevation: 10,
    isDismissible: false,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * .40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: const [
                SizedBox(
                  height: 40,
                ),
                ImagePreview(),
                ModalTextField(),
                ModalButton()
              ],
            ),
          ),
        ),
      );
    },
  );
}
