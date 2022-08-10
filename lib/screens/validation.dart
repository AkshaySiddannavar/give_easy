import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/create_request.dart';
import 'package:give_easy/screens/request_creation_success.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ValidationScreen extends StatefulWidget {
  static const String id = 'validation_screen';
  Map<String, dynamic> newRequestData;
  ValidationScreen({Key? key, this.newRequestData = kDefaultRequestData})
      : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  File file = File('');
  static final _auth = FirebaseAuth.instance;
  static final storage = FirebaseStorage.instance;
  static final storageRef = FirebaseStorage.instance.ref();
  // ignore: prefer_typing_uninitialized_variables
  late final fileDownloadURL;
  bool downloadURLReady = false;
  //For now this way will work to directly store downloadURL
  //Though in future if you want to retreive data then you will have to also store file name along with downloadURL for fetching a new downloadURL
  //(later)

  double progress = 0;
  String organizationName = '';

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
      final fileBaseName = p.basename(file.path); //just file's name

      var currentDateTime = DateTime.now().toString();

      final fileUploadName =
          '${_auth.currentUser!.uid}___$currentDateTime'; // file will be uploaded with this name

      final destinationRef =
          storageRef.child('organization_proofs/$fileUploadName');

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

      final uploadTask = destinationRef
          .putFile(file); //starting the task of uploading the file

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            progress = (100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes))
                .roundToDouble();
            //TODO: optimize setState calling later on
            //when optimizing setState call it only after progress has changed for a decent value
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
            print('_ _ _ _ _ ___ _ _ _ _ \nERROR ERROR\n__ _ __ _ _');
            break;
          case TaskState.success:
            print('**************88');
            fileDownloadURL = await destinationRef.getDownloadURL();
            downloadURLReady = true;
            setState(() {});

            break;
        }
      });
    }
  }

  void setNewRequestMap() {
    String category = widget.newRequestData["category"];
    String description = widget.newRequestData["description"];
    double goalAmount = widget.newRequestData["goalAmount"];
    String previewImageRef = widget.newRequestData["previewImageRef"];
    String title = widget.newRequestData["title"];

    widget.newRequestData = {
      "category": category, //added in create req screen [1.]
      "collectedAmount": -1,
      "creator": _auth.currentUser!.uid, //Added in validationscreen [1.]
      "description": description, //added in create req screen [2.]
      "goalAmount": goalAmount, //added in create req screen [3.]
      "organizationName": organizationName, //Added in validationscreen [2.]
      "previewImageRef":
          previewImageRef, //added in create req screen(change later) //later on code it such that preview image is uploaded after validation is performed [4.]
      "status": 'active', //Added in validationscreen [3.]
      "title": title, //added in create req screen [5.]
    };
  }

  void uploadRequestData() {
    final _firestore = FirebaseFirestore.instance;

    _firestore.collection('specific-request-data').add(widget.newRequestData);
  }
  //TODO: add exception handling(later)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Validation Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: kInputTextFieldDecoration.copyWith(
                    hintText: '', labelText: 'Organization Name'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {});
                    organizationName = value;
                  }
                },
              ),
            ),
            Text(
              'Enter Name of Organization Organizing This Fundraiser',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Flexible(
              child: SizedBox(
                height: 35.0,
              ),
            ),
            Text(
              'Upload Proof of Your Membership\nIn Organization',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            ActionButton(
              buttonText: 'Select File',
              buttonActionCallback: selectFile,
              buttonColor: Colors.blueAccent,
            ),
            Flexible(
                child: SizedBox(
              height: 10,
            )),
            Text(
              'Selected File:\n' +
                  ((p.basename(file.path).toString() == '')
                      ? 'None'
                      : p.basename(file.path).toString()),
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Flexible(
                child: SizedBox(
              height: 30,
            )),
            ActionButton(
              buttonText: 'Upload File',
              buttonActionCallback: uploadFile,
              buttonColor: Colors.blueAccent,
            ),
            Text(
              'Upload Progress:\n$progress%',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Flexible(
                child: SizedBox(
              height: 30,
            )),
            ActionButton(
              buttonText: 'Create Request',
              buttonActionCallback: () {
                setNewRequestMap();
                uploadRequestData(); //upload data into firestore

                print(
                    '*************************\n$fileDownloadURL\n*****************');

                Navigator.pushNamed(context, RequestCreationSuccessScreen.id);
              },
              buttonColor: Colors.blueAccent,
              isActive: ((progress == 100.0) &&
                      (organizationName.isNotEmpty) &&
                      downloadURLReady)
                  ? true
                  : false,
            )
          ],
        ),
      ),
    );
  }
}
