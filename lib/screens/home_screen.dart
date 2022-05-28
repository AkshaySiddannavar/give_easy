import 'package:flutter/material.dart';
import 'package:give_easy/components/categorical_tile.dart';
import 'package:give_easy/components/preview_card.dart';
import 'package:give_easy/screens/all_screens.dart';

//replaced ListView with a ListView.builder
//this given list will be rendered on screen
//works as expected with some minor UI changes which we can focus later on after app is done

List<CategoricalTile> listOfAllCategoricalTiles = [
  CategoricalTile(categoryName: 'Category 1', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
  CategoricalTile(categoryName: 'Category 2', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
  CategoricalTile(categoryName: 'Category 3', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
  CategoricalTile(categoryName: 'Category 4', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
  CategoricalTile(categoryName: 'Category 5', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
  CategoricalTile(categoryName: 'Category 6', categorySpecificList: [
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
    PreviewCard(previewImage: Image.asset('assets/images/handshake.png')),
  ]),
];

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //it is transparent
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 1.0,
        elevation: 0.0,
        bottomOpacity: 1.0,
        toolbarOpacity: 1.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Text(
          'Title',
          style: TextStyle(
              color: Colors.black, backgroundColor: Colors.transparent),
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
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return listOfAllCategoricalTiles[index];
        }),
        itemCount: listOfAllCategoricalTiles.length,
      ),
    );
  }
}
