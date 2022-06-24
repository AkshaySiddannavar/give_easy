import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/all_screens.dart';

class PreviewCard extends StatelessWidget {
  final Image previewImage; //image shown in PreviewCard
  final String title; //title from specific-request-data

  const PreviewCard(
      {Key? key,
      this.previewImage = kDefaultPreviewImage,
      this.title = 'Donation For Some Cause'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SpecificDonationScreen.id);
      },
      child: Column(
        children: [
          Container(
            height: 125.0,
            width: 125.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color:
                    Colors.tealAccent, //to identify extent of outer container
                borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0))),
            child: Container(
              //inner container
              //replace it with padding later on if required

              decoration: BoxDecoration(
                  color: Colors.redAccent, //to see extent of container

                  borderRadius: BorderRadius.all(Radius.circular(20.0))),

              child: Flex(
                  direction: Axis
                      .horizontal, //change direction in case required later on

                  children: [Flexible(child: previewImage)]
                  //We use Flex > Flexible so that we can change size of image from its original size
                  ),
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
