import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ValidationScreen extends StatelessWidget {
  static const String id = 'validation_screen';

  ValidationScreen({Key? key}) : super(key: key);

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        //something which can be used to test if files are uploaded on google storage (do it later along with docs)
      ),
    );
  }
}
