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
