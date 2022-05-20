import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 1.0,
        toolbarOpacity: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Title',
          style: TextStyle(color: Colors.black),
        ),
        leading: //Profile Icon/Pic will come here
            Container(
          padding:
              EdgeInsets.only(bottom: 8.0, right: 8.0, left: 5.0, top: 5.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 70.0,
          ),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(30.0, 30.0),
            ),
          ),
        ),
        actions: //Hero animation will come here, it will be the only thing in this list
            [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'appIconTransition',
              child: Image.asset('assets/images/handshake.png'),
            ),
          ),
        ],
      ),
    );
  }
}
