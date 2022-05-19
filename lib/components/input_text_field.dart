import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';

class InputTextField extends StatefulWidget {
  final String hintMessage;
  final TextInputType type; //type of keyboard
  final bool isSensitive; // for sensitive data
  final void Function(String)? currentTextCallback;
  const InputTextField(
      {Key? key,
      required this.hintMessage,
      required this.isSensitive,
      required this.currentTextCallback,
      this.type = TextInputType.text})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late String currentText;
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: widget.type,
        onChanged: widget.currentTextCallback,
        obscureText: widget.isSensitive,
        textAlign: TextAlign.center,
        decoration:
            kInputTextFieldDecoration.copyWith(hintText: widget.hintMessage));
  }
}
