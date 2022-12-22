//[space [Gender]       [value] [edit pencil icon - on tap it will lead us to respective screen and edit it]space]

import 'package:flutter/material.dart';

class ProfileElementTile extends StatelessWidget {
  final String profileElementName;
  final String profileElementValue;
  final void Function()? onTap;
  const ProfileElementTile(
      {Key? key,
      required this.profileElementName,
      required this.profileElementValue,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
      child: ListTile(
        leading: Text(
          profileElementName,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        title: Text(
          profileElementValue.length < 35
              ? profileElementValue
              : '${profileElementValue.substring(0, 15)}\n${profileElementValue.substring(15, 25)}...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: IconButton(
          onPressed: onTap,
          icon: Icon(
            color: Colors.black,
            Icons.keyboard_arrow_right_sharp,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
