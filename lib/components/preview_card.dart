import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/screens/all_screens.dart';

//added navigation to specificDonationScreen on tap with GestureDetector
//how to pass values to specificDonationScreen ? I am using screen id to navigate to it

class PreviewCard extends StatelessWidget {
  final Image previewImage; //image shown in PreviewCard

  const PreviewCard({
    Key? key,
    this.previewImage = kDefaultPreviewImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //outer container
      height: 125.0,
      width: 125.0,
      //height and width such that at least 3 of PreviewCards should be visible by default
      //change it later in case required

      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, SpecificDonationScreen.id);
        },
        child: Container(
          //inner container
          //replace it with padding later on if required

          decoration: BoxDecoration(
              color: Colors.redAccent, //to see extent of container

              borderRadius: BorderRadius.all(Radius.circular(20.0))),

          child: Flex(
              direction:
                  Axis.horizontal, //change direction in case required later on

              children: [Flexible(child: previewImage)]
              //We use Flex > Flexible so that we can change size of image from its original size
              ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.tealAccent, //to identify extent of outer container
          borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0))),
    );
  }
}
