import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final Image backgroundImage;
  const TitleTile(
      {Key? key,
      this.title = 'default title',
      this.backgroundImage = kDefaultPreviewImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: backgroundImage.image),
        //Img.image converts an Image object into ImageProvider<Object>
        color: Colors.pinkAccent,
        //color is just for facilitating debugging change later
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: TextStyle(
            backgroundColor: Colors.white54,
            //color is just for facilitating debugging change later
          ),
        ),
      ),
    );
  }
}
