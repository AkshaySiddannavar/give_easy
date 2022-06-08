import 'dart:io';
import 'dart:typed_data';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/create_request.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ValidationScreen extends StatefulWidget {
  static const String id = 'validation_screen';

  ValidationScreen({Key? key}) : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  File file = File('');
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  double progress = 0;
  String currentString = '';

  void selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      final path = result.files.single.path;
      if (path == null) {
        print('*************************\npath is null\n********************');
      } else {
        setState(() {
          file = File(path);
        });
      }
    }
  }

  void uploadFile() async {
    if (file == null) {
      print('*************************\nfile is null\n********************');
    } else {
      final fileName = p.basename(file.path);
      final destinationRef = storageRef.child('uploads/${fileName}');

      showToast(
        'Uploading...\nPlease wait till 100% file is uploaded',
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 5),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: Colors.grey,
      );

      final uploadTask = destinationRef.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            progress = (100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes))
                .roundToDouble();
            print("Upload is $progress% complete.");
            setState(() {});
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            break;
        }
      });

      if (uploadTask.snapshot.state == TaskState.success) {
        var downloadURL = await destinationRef.getDownloadURL();
      }
    }
  }

  //add exception handling
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Organization\nName'),
              Expanded(
                child: TextField(
                  decoration: kInputTextFieldDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      currentString = value;
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('Organization Membership Proof'),
          ActionButton(
              buttonText: 'Select File', buttonActionCallback: selectFile),
          Container(
            child: Text('File Selected ' + file.toString()),
          ),
          ActionButton(
              buttonText: 'Upload File', buttonActionCallback: uploadFile),
          Text(
            '$progress',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          ActionButton(
            buttonText: 'Create Request',
            buttonActionCallback: () {
              Navigator.pushNamed(context, CreateRequestScreen.id);
            },
            isActive: ((progress == 100.0) && (currentString.isNotEmpty))
                ? true
                : false,
          )
        ],
      ),
    );
  }
}
