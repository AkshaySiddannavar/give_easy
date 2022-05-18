import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';

class InputTextField extends StatefulWidget {
  final String hintWord;
  final bool isObscure;
  const InputTextField(
      {Key? key, required this.hintWord, required this.isObscure})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: widget.isObscure,
        textAlign: TextAlign.center,
        decoration:
            kInputTextFieldDecoration.copyWith(hintText: widget.hintWord));
  }
}
