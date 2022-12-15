import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/components/preview_card.dart';
import 'package:give_easy/constants.dart';

class CategoricalTile extends StatefulWidget {
  final String categoryName;

  final List categorySpecificList;

  final bool fetchListFromFirestore;

  const CategoricalTile(
      {Key? key,
      this.categoryName = 'none',
      this.fetchListFromFirestore = false,
      this.categorySpecificList = kDefaultCategorySpecificListContent})
      : super(key: key);

  static final _firestore = FirebaseFirestore.instance;

  @override
  State<CategoricalTile> createState() => _CategoricalTileState();
}

class _CategoricalTileState extends State<CategoricalTile> {
  Widget listOfFuturePreviewCards = Container();

  Future<List> getPreviewCardDataFromFirestore(String categoryName) async {
    //categoryName -(this function)> listOfpreviewCards to be rendered or list of data to be stored in those preview cards

    final requestCollectionRef =
        CategoricalTile._firestore.collection('specific-request-data');

    final getAllRequestsOfACategory = await requestCollectionRef
        .where("category", isEqualTo: categoryName)
        .where("status", isEqualTo: "active")
        .get()
        .then((value) => value,
            onError: (e) => print("************\n$e\n***********"));

    List allDocumentsOfACategory = getAllRequestsOfACategory.docs;
    //Now, we have all data required to render PreviewCards on screen

    return allDocumentsOfACategory;
  }

  Future<Widget> listViewBuilderForACategory(String categoryName) async {
    List listOfDataInPreviewcard =
        await getPreviewCardDataFromFirestore(categoryName);

    listOfFuturePreviewCards = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var data = listOfDataInPreviewcard[index];
        String title = data["title"];
        String previewImageRef = data["previewImageRef"];

        Image previewImage = Image.network(previewImageRef);
        print('title is title $title');
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PreviewCard(
            title: title,
            previewImage: previewImage,
          ),
        );
      },
      itemCount: listOfDataInPreviewcard.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
    );

    return listOfFuturePreviewCards;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 220.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //container for CategoryName
            //replace with padding later if required
            //using container in order to see extent of this widget with color property

            // color: Color(0xFFFFAB40),

            child: Text(
              widget.categoryName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.35,
                  decorationColor: Colors.greenAccent),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: SizedBox(
              height: 100.0,
              child: (widget.fetchListFromFirestore)
                  ? FutureBuilder(
                      future: listViewBuilderForACategory(widget.categoryName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('error'));
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: listOfFuturePreviewCards,
                          );
                        }
                      }) //when we will be using firestore
                  : ListView.builder(
                      itemBuilder: ((context, index) {
                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widget.categorySpecificList[index],
                            //only this part will change depending on whether we manually enter the list or we dynamically fetch the list of PreviewCards
                          ),
                        );
                      }),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      shrinkWrap: true,
                      itemCount: widget.categorySpecificList.length,
                    ), //when we won't be using firestore
            ),
          ),
        ],
      ),
    );
  }
}
