import 'package:flutter/material.dart';
import 'package:give_easy/constants.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final Image backgroundImage;
  final String organizationName;
  const TitleTile(
      {Key? key,
      this.title = 'default title',
      this.backgroundImage = kDefaultPreviewImage,
      this.organizationName = 'default organization'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: backgroundImage.image),
        //Img.image converts an Image object into ImageProvider<Object>
        color: kGiveEasyGreen,
        //color is just for facilitating debugging change later
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                backgroundColor: Colors.white54,
                fontWeight: FontWeight.w500,
                //color is just for facilitating debugging change later
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "By $organizationName",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.white54,
                //color is just for facilitating debugging change later
              ),
            ),
          ),
        ],
      ),
      //Add a tile for organization name as "~By OrgName" will need to test UI
    );
  }
}
