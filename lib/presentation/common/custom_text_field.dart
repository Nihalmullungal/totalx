import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final TextInputType? keyboard;
  final TextEditingController cont;
  Widget? prefix;
  final void Function(String)? onChanged;
  bool isSearch;
  CustomTextField({
    super.key,
    required this.hint,
    this.isSearch = false,
    this.hintStyle,
    this.keyboard,
    this.prefix,
    this.onChanged,
    required this.cont,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      onChanged: onChanged,
      controller: cont,
      cursorColor: const Color.fromRGBO(0, 0, 0, 1),
      decoration: InputDecoration(
          prefixIcon: prefix,
          focusedBorder: isSearch
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ))
              : const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
          contentPadding: const EdgeInsets.all(10),
          hintText: hint,
          hintStyle: hintStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isSearch ? 20 : 5),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
              ))),
    );
  }
}
