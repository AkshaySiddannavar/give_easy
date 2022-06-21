import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';

class InputTextField extends StatefulWidget {
  final String hintMessage;
  final TextInputType type; //type of keyboard
  final bool isSensitive; // for sensitive data
  final void Function(String)? currentTextCallback;
  final String? defaultText;
  final String? textFieldLabel;
  const InputTextField(
      {Key? key,
      required this.hintMessage,
      required this.isSensitive,
      required this.currentTextCallback,
      this.type = TextInputType.text,
      this.defaultText,
      this.textFieldLabel})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late String currentText;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: (widget.defaultText == null || widget.defaultText == '')
            ? null
            : TextEditingController(
                text: widget
                    .defaultText), //instantiating controller only when defaultText is supplied
        keyboardType: widget.type,
        onChanged: widget.currentTextCallback,
        obscureText: widget.isSensitive,
        textAlign: TextAlign.center,
        decoration: kInputTextFieldDecoration.copyWith(
            hintText: widget.hintMessage,
            labelText: widget.textFieldLabel)); //make it optional and specific
  }
}
