import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController heroIconController;
  @override
  void initState() {
    super.initState();
    heroIconController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 50.0,
        upperBound: 150.0);

    heroIconController.forward();
    heroIconController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: 'appIconTransition',
              child: SizedBox(
                height: heroIconController.value,
                child: FaIcon(
                  size: heroIconController.value,
                  FontAwesomeIcons.handshake,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
