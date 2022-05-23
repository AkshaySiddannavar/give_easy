import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final void Function()? buttonActionCallback;
  final Color buttonColor;
  final double verticalPadding;
  final double horizontalPadding;

  const ActionButton(
      {Key? key,
      required this.buttonText,
      required this.buttonActionCallback,
      this.buttonColor = Colors.amber,
      this.horizontalPadding = 25.0,
      this.verticalPadding = 15.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
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
