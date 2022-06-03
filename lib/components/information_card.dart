import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String cardInformation;
  const InformationCard(
      {Key? key, this.cardInformation = 'No Information To Display'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //outer container
      height: 250.0,
      width: 250.0,
      //height and width such that at least 1 InformationCard should be visible and 2nd partially visible
      //change it later in case required

      padding: EdgeInsets.all(8.0),
      child: Container(
        //inner container
        //replace it with padding later on if required

        decoration: BoxDecoration(
            color: Colors.pinkAccent, //to see extent of container

            borderRadius: BorderRadius.all(Radius.circular(20.0))),

        child: Flex(
            direction:
                Axis.horizontal, //change direction in case required later on

            children: [
              Flexible(
                child: Text(cardInformation),
              ),
            ]
            //We use Flex > Flexible so that we can change size of Text from its original size
            ),
      ),

      decoration: BoxDecoration(
          color: Colors.lightBlue, //to identify extent of outer container
          borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0))),
    );
  }
}
