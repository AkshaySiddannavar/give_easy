import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/components/input_text_field.dart';

class RegisterationScreen extends StatefulWidget {
  static const String id = 'Registeration_screen';
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'appIconTransition',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('assets/images/handshake.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InputTextField(
                      hintWord: 'Enter Email',
                      isObscure: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InputTextField(
                        hintWord: 'Enter Password', isObscure: true),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ActionButton(
                  buttonText: 'Register',
                  buttonActionCallback: () {},
                ),
              ]),
        ),
      ),
    );
  }
}
