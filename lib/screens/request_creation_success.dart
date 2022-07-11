import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/screens/all_screens.dart';

class RequestCreationSuccessScreen extends StatefulWidget {
  static const String id = 'request_creation_success_screen';
  const RequestCreationSuccessScreen({Key? key}) : super(key: key);

  @override
  State<RequestCreationSuccessScreen> createState() =>
      _RequestCreationSuccessScreenState();
}

class _RequestCreationSuccessScreenState
    extends State<RequestCreationSuccessScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  void triggerConfetti() {
    _controllerCenter.play();
  }

  //* Remember to keep number of particles as low as possible or else there will be performance issue
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => triggerConfetti());
    return Stack(children: [
      //STAR Confetti
      Align(
        alignment: Alignment.center,
        child: ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ], // manually specify the colors to be used
          createParticlePath: drawStar, // define a custom shape/path.
          numberOfParticles: 4,
        ),
      ),
      ActionButton(
          buttonText: 'Yay!',
          buttonActionCallback: () =>
              Navigator.pushReplacementNamed(context, HomeScreen.id)),
    ]);
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }
}
