import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/request_creation_success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:give_easy/screens/validation.dart';
import 'package:path/path.dart' as p;

class CreateRequestScreen extends StatefulWidget {
  static const String id = 'create_requests_screen';
  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  static Reference storageRef =
      FirebaseStorage.instance.ref(); //points to root in storage

  final previewImageFolderRef = storageRef.child(
      '/preview_images/'); // reference to the folder where all preview images will be uploaded

  late File file = File(''); //initializing with empty path to avoid app crash
  double progress = 0.0;
  bool uploadIsActive = false;

  late var previewImageDownloadRef;

  late Map<String, dynamic> currentRequestData;
  //This will store information about request created in this screen
  //This will be passed on to valdiation screen
  //Only uploaded into firestore after validation is successful

  String dropdownValue = 'Select Category';

  // List of items in our dropdown menu
  List<String> categories = [
    'Select Category',
    'Clothe Aid',
    'Disaster Relief Aid',
    'Food Aid',
    'War Relief Aid',
  ];
  //All categories
  /*
              1. Clothe Aid
              2. Disaster Relief Aid
              3. Food Aid
              4. Homeless people Aid
              5. War Relief Aid
              6. Water Aid

              7. dummy
              */

  late String title, description, currentCategorySelected;
  late double goalAmount;

  void selectFile() async {
    //works as expected
    final result = await FilePicker.platform.pickFiles(
        allowedExtensions: kAllowedExtensionsForPreviewImage,
        type: FileType.custom);

    if (result != null) {
      setState(() {});
      if (kIsWeb) {
        file = File(result.files.first.bytes.toString());
      } else {
        file = File(result.files.single.path!);
      }
    } else {
      //TODO: Show some toast(later)
    }
  }

  void uploadFile() async {
    //works as expected

    //storing it in 'preview_image' folder
    //storing with '<req_title>.ext' name

    final previewImageLocation = previewImageFolderRef.child(title);
    //reference to location where preview image for the request being created will be stored along with name of file

    final uploadTask =
        previewImageLocation.putFile(file); //starting upload task

    uploadTask.snapshotEvents.listen((TaskSnapshot uploadTaskSnapshot) async {
      switch (uploadTaskSnapshot.state) {
        case TaskState.running:
          //running
          progress = ((uploadTaskSnapshot.bytesTransferred /
                      uploadTaskSnapshot.totalBytes) *
                  100)
              .roundToDouble();
          print('*****************\nprogress : $progress\n****************');
          setState(() {});
          //optimize setState calling later on
          //when optimizing setState call it only after progress has changed for a decent value
          break;

        case TaskState.success:
          //success
          break;
        case TaskState.canceled:
          //canceled
          break;
        case TaskState.error:
          //error
          break;
        case TaskState.paused:
          //paused
          break;

        default:
          print('******************\ndefault ran\n******************');
      }

      if (uploadTask.snapshot.state == TaskState.success) {
        previewImageDownloadRef = await previewImageLocation.getDownloadURL();
        //stores this URL in firestore

        uploadIsActive = true;
        print('*****************\ncomplete\n****************');
        print('*****************\n$previewImageDownloadRef\n****************');
        setState(() {});
      }
    });
  }

  void setNewRequestMap() {
    currentRequestData = {
      "category": currentCategorySelected, //added in create req screen [1.]
      "collectedAmount": -1,
      "creator": 'NO DATA', //Added in validationscreen [1.]
      "description": description, //added in create req screen [2.]
      "goalAmount": goalAmount, //added in create req screen [3.]
      "organizationName": 'NO DATA', //Added in validationscreen [2.]
      "previewImageRef":
          previewImageDownloadRef, //added in create req screen(change later) //later on code it such that preview image is uploaded after validation is performed [4.]
      "status": 'NO DATA', //Added in validationscreen [3.]
      "title": title, //added in create req screen [5.]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Creation Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  onChanged: (currentTitle) {
                    title = currentTitle;
                    //no need to call setState() we aren't going to re-build screen for this
                    //value of variable will be changed internall though no setState will be called
                  },
                  decoration: kInputTextFieldDecoration.copyWith(
                      hintText: '', labelText: 'Enter Title of Request'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  onChanged: (currentDescription) {
                    description = currentDescription;
                  },
                  decoration: kInputTextFieldDecoration.copyWith(
                    hintText: 'Enter Description of Request',
                  ),
                  maxLines: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType:
                      TextInputType.phone, //For simpler input of numbers
                  decoration: kInputTextFieldDecoration.copyWith(
                      hintText: '', labelText: 'Enter Goal Amount of Request'),
                  onChanged: (typedAmount) {
                    goalAmount = num.parse(typedAmount).toDouble();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DropdownButton(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  // Initial Value
                  value: dropdownValue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: categories.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      currentCategorySelected = dropdownValue;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ActionButton(
                    buttonText: 'Select Preview Image',
                    buttonActionCallback: selectFile,
                    buttonColor: Colors.blueAccent),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    (kIsWeb)
                        ? (file.path.toString().isNotEmpty)
                            ? 'Image File Successfully Selected'
                            : 'Please Select An Image File\n'
                        : 'Preview Image Name:\n${p.basename(file.path)}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ActionButton(
                    buttonText: 'Upload Preview Image',
                    buttonActionCallback: uploadFile,
                    buttonColor: Colors.blueAccent),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Upload Progress:\n$progress',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ActionButton(
                  buttonText: 'Create Request',
                  buttonActionCallback: () {
                    setNewRequestMap();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ValidationScreen(
                          newRequestData: currentRequestData,
                        ),
                      ),
                    );
                  },
                  buttonColor: Colors.blueAccent,
                  isActive: uploadIsActive,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
