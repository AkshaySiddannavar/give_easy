import 'package:flutter/material.dart';
import 'package:give_easy/components/preview_card.dart';
import 'package:give_easy/constants.dart';

class CategoricalTile extends StatelessWidget {
  //we will keep it stateless since ListView is also stateless
  //in case required we can later change it to stateful
  final String categoryName;

  final List categorySpecificList;
  const CategoricalTile(
      {Key? key,
      this.categoryName = 'none',
      this.categorySpecificList = kDefaultCategorySpecificListContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 200.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //container for CategoryName
            //replace with padding later if required
            //using container in order to see extent of this widget with color property

            color: Colors.orangeAccent,

            child: Text(
              categoryName,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: SizedBox(
              height: 100.0,
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: categorySpecificList[index],
                    ),
                  );
                }),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                shrinkWrap: true,
                itemCount: categorySpecificList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
