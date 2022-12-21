import 'package:flutter/material.dart';
import 'package:give_easy/screens/information_screen.dart';

class InformationCard extends StatelessWidget {
  final String displayTextTitle;

  const InformationCard({
    Key? key,
    this.displayTextTitle = 'NO TITLE',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        print(displayTextTitle);
        return InformationScreen(title: displayTextTitle);
      })),
      child: Container(
        //outer container
        height: 250.0,
        width: 150.0,
        //height and width such that at least 1 InformationCard should be visible and 2nd partially visible
        //change it later in case required

        padding: EdgeInsets.all(8.0),
        child: Container(
          //inner container
          //replace it with padding later on if required

          decoration: BoxDecoration(
              // color: Colors.pinkAccent, //to see extent of container

              borderRadius: BorderRadius.all(Radius.circular(20.0))),

          child: Flex(
              direction:
                  Axis.vertical, //change direction in case required later on

              children: [
                Flexible(
                  child: Center(
                      child: Text(
                    displayTextTitle == 'give'
                        ? 'What\'s a\n      $displayTextTitle?'
                        : 'What\'s a\n$displayTextTitle?',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
                Center(child: Text('Tap To Learn')),
              ]
              //We use Flex > Flexible so that we can change size of Text from its original size
              ),
        ),

        decoration: BoxDecoration(
            //gradient: LinearGradient() to add some good looks
            gradient: LinearGradient(colors: [
              Color.fromARGB(218, 1, 246, 222),
              Color.fromARGB(218, 6, 247, 223),
              Color(0xFF00FFA4),
              // Color.fromARGB(218, 2, 235, 212),

              // Color.fromARGB(255, 70, 173, 246)
            ]),
            // color: Colors.greenAccent, //to identify extent of outer container
            borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0))),
      ),
    );
  }
}
