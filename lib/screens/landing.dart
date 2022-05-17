import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/screens/login.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: 'appIconTransition',
              child: SizedBox(
                height: 50.0,
                child: FaIcon(
                  size: 50.0,
                  FontAwesomeIcons.handshake,
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Login',
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            TextButton(onPressed: () {}, child: Text('Register')),
          ]),
        ),
      ),
    );
  }
}
