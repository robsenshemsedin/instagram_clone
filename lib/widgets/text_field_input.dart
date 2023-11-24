import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final bool isPassword;

  final TextEditingController textEditingController;

  const TextFieldInput(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
        decoration: InputDecoration(
          // focusedBorder: ,
          // enabledBorder: ,
          border: inputBorder,

          hintText: hintText,
        ),
        controller: textEditingController,
        obscureText: isPassword);
  }
}
