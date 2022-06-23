import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Consumer<userData>(
      builder: (context, userDataObject, child) => Scaffold(
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
                        type: TextInputType.emailAddress,
                        hintMessage: 'Enter Email',
                        isSensitive: false,
                        currentTextCallback: (value) {
                          email = value;
                        },
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
                        hintMessage: 'Enter Password',
                        isSensitive: true,
                        currentTextCallback: (value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ActionButton(
                    buttonText: 'Login',
                    buttonActionCallback: () async {
                      try {
                        var currentUserCredentials =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                        userDataObject.updateFullProfile();
                        //replaces all default 'loading...' values with actual values for current user
                        if (!mounted)
                          return; //When a BuildContext is used from a StatefulWidget, the mounted property must be checked after an asynchronous gap.

                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } catch (e) {
                        print('error message is : $e');
                      }
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
