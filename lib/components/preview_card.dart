import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/all_screens.dart';

//onTap : Navigator.push(context, SpecificDonationScreen(title));
//SpecificDonationScreen will be rendered using firestore by using title as unique identifier

class PreviewCard extends StatelessWidget {
  final Image previewImage; //image shown in PreviewCard
  final String
      title; //title from specific-request-data through categorical-tile

  const PreviewCard(
      {Key? key,
      this.previewImage = kDefaultPreviewImage,
      this.title = 'Donation For Some Cause'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('\n\npreview card ran\n\n');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpecificDonationScreen(
                      donationTitle: title,
                    )));
      },
      child: Column(
        children: [
          Container(
            height: 125.0,
            width: 125.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                // boxShadow: ,
                color: Colors.white70, //to identify extent of outer container
                borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0))),
            child: Flex(
                direction: Axis
                    .horizontal, //change direction in case required later on
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: AspectRatio(
                          aspectRatio: 15.0 / 11.0, child: previewImage))
                ]
                //We use Flex > Flexible so that we can change size of image from its original size
                ),
          ),
          Text(
            title.length > 20 ? '${title.substring(0, 19)}...' : title,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
