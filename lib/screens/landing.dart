import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:give_easy/screens/login.dart';
import 'package:give_easy/constants.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGiveEasyGreen,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Hero(
                tag: 'appIconTransition',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGiveEasyGreen,
                  ),
                  height: 75.0,
                  child: Container(
                      child: Image.asset('assets/images/handshake.png')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
              child: TextButton(
                  child: Text(
                    'Login',
                    style: kDarkAppBarTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),

                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    // padding: MaterialStateProperty.all(
                    //     const EdgeInsets.symmetric(
                    //         vertical: 5, horizontal: 30)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterationScreen.id);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  child: Text(
                    'Register',
                    style: kDarkAppBarTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
