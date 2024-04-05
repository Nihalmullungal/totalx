import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final TextInputType? keyboard;
  final TextEditingController cont;
  const CustomTextField({
    super.key,
    required this.hint,
    this.hintStyle,
    this.keyboard,
    required this.cont,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: cont,
      cursorColor: const Color.fromRGBO(0, 0, 0, 1),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          contentPadding: const EdgeInsets.all(10),
          hintText: hint,
          hintStyle: hintStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
              ))),
    );
  }
}
