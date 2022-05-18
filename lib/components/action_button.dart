import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final void Function()? buttonActionCallback;
  const ActionButton(
      {Key? key, required this.buttonText, required this.buttonActionCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 25.0,
      ),
      child: Material(
        elevation: 5.0,
        color: Colors.amber,
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
        child: MaterialButton(
          height: 45.0,
          onPressed: buttonActionCallback,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
