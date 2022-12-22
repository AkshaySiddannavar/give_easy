import 'package:flutter/material.dart';
import 'package:give_easy/components/preview_card.dart';

const kInputTextFieldDecoration = InputDecoration(
  hintText: 'Hint Text Here',
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black87),
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black87),
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
  hintStyle: TextStyle(color: Colors.black),
  labelStyle: TextStyle(color: Colors.black),
);

const String kDefaultPreviewImagePath = 'assets/images/handshake.png';
//Default Preview Image Path for preview_card

const Image kDefaultPreviewImage =
    Image(image: AssetImage(kDefaultPreviewImagePath));
//Default Preview Image for preview_card

const kDefaultCategorySpecificListContent = [
  PreviewCard(
    previewImage: kDefaultPreviewImage,
  )
];

const int kMaxAmountAllowed = 100 * 1000;
//maximum amount of donation allowed per transaction
//int * int = int (dart)

const String kButtonDisabledMessage =
    'Button is disabled\nPlease Enter a Valid Amount\n1.Should be numbers only\n2.Should be more than 0\n3.Should be less than $kMaxAmountAllowed';

const Widget kTaglineWidget = Text(
    'Your donation will be used to futher the cause that matters to you ❤️', //add tagline
    style: TextStyle(fontSize: 15.0, color: Colors.black),
    textAlign: TextAlign.center);

const Widget kDarkThemeTaglineWidget = Text(
    'Your donation will be used to futher the cause that matters to you ❤️', //add tagline
    style: TextStyle(fontSize: 15.0, color: kGiveEasyGreen),
    textAlign: TextAlign.center);

const kAllowedExtensionsForPreviewImage = [
  'jpg',
  'jpeg',
  'png',
  'cr2', //raw image format created directly by camera
  'crw', //raw image format created directly by camera
  'nef', //raw image format created directly by camera
  'svg'
];

const Map<String, dynamic> kDefaultUserData = {
  "gender": 'NO DATA',
  "organizationName": 'NO DATA',
  "phoneNumber": 'NO DATA',
  "userEmail": 'NO DATA',
  "userName": 'NO DATA',
  "uniqueID": 'NO DATA',
};

const Map<String, dynamic> kDefaultRequestData = {
  "category": 'NO DATA', //added in create req screen [1.]
  "collectedAmount": -1,
  "creator": 'NO DATA', //Added in validationscreen [1.]
  "description": 'NO DATA', //added in create req screen [2.]
  "goalAmount": -1, //added in create req screen [3.]
  "organizationName": 'NO DATA', //Added in validationscreen [2.]
  "previewImageRef":
      'NO DATA', //added in create req screen(change later) //later on code it such that preview image is uploaded after validation is performed [4.]
  "status": 'NO DATA', //Added in validationscreen [3.]
  "title": 'NO DATA', //added in create req screen [5.]
};

const TextStyle kDarkAppBarTextStyle = TextStyle(
  color: Color(0xFF00FFA4),
  fontSize: 25,
  fontWeight: FontWeight.w900,
);

const Color kDarkAppBarBackgroundColor = Colors.black;

const Color kGiveEasyGreen = Color(0xFF00FFA4);
