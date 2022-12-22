import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:give_easy/constants.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final void Function()? buttonActionCallback;
  final Color buttonColor;
  final Color textColor;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isActive;

  const ActionButton(
      {Key? key,
      required this.buttonText,
      required this.buttonActionCallback,
      this.buttonColor = Colors.black,
      this.textColor = kGiveEasyGreen,
      this.horizontalPadding = 25.0,
      this.verticalPadding = 15.0,
      this.isActive = true})
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
        color: isActive ? buttonColor : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
        child: MaterialButton(
          height: 45.0,
          onPressed: isActive
              ? buttonActionCallback
              : () {
                  showToast(
                    context: context,
                    kButtonDisabledMessage,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 5),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                    backgroundColor: Colors.redAccent,
                  );
                },
          child: Text(
            buttonText,
            style: TextStyle(
              color: isActive ? textColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
