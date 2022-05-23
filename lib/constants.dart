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
