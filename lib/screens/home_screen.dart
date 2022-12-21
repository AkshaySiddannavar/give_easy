import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/categorical_tile.dart';
import 'package:give_easy/components/information_card.dart';
import 'package:give_easy/components/preview_card.dart';
import 'package:give_easy/information_data_API/information_data_api.dart';
import 'package:give_easy/screens/all_screens.dart';
import 'package:give_easy/screens/create_request.dart';
import 'package:give_easy/screens/current_request.dart';
import 'package:give_easy/screens/past_requests.dart';
import 'package:give_easy/screens/profile.dart';
import 'package:give_easy/screens/validation.dart';
import 'package:give_easy/screens/your_gives.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

//replaced ListView with a ListView.builder
//this given list will be rendered on screen
//works as expected with some minor UI changes which we can focus later on after app is done

//TODO: add contents into information card
//use firestore to load all preview cards(with their previewImages and title)

List<CategoricalTile> listOfAllCategoricalTiles = [
  CategoricalTile(
    categoryName: 'Basic Information',
    categorySpecificList: [
      InformationCard(displayTextTitle: 'give'),
      InformationCard(displayTextTitle: 'request'),
    ],
  ),
  CategoricalTile(categoryName: 'Clothe Aid', fetchListFromFirestore: true),
  CategoricalTile(
      categoryName: 'Disaster Relief Aid', fetchListFromFirestore: true),
  CategoricalTile(categoryName: 'Food Aid', fetchListFromFirestore: true),
  CategoricalTile(categoryName: 'War Relief Aid', fetchListFromFirestore: true),
];

final _firestore = FirebaseFirestore.instance;

void getCategories() async {
  //gets a list of categories

  CollectionReference<Map<String, dynamic>> allCategoryDocuments =
      _firestore.collection("category-name");

  QuerySnapshot getAllCategoryDocuments = await allCategoryDocuments
      .get()
      .then((value) => value, onError: (e) => print(e));

  List listOfAllCategories =
      getAllCategoryDocuments.docs; //List of query snapshots

  // for (var snapshot in getAllCategoryDocuments.docs) {
  //   var id = snapshot.id;
  //   if (id == 'dummy') continue;

  //   print(id);
  // }

  // print(listOfAllCategories);
}

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userDataObject, child) {
      String username = userDataObject.profileData["userName"];
      String usernameDisplay = (username.length > 12)
          ? "${username.substring(0, 12)}+..."
          : username;
      int lengthOfUsername = username.length;
      String userImageInitials = username.substring(0, 1).toUpperCase() +
          username.substring(lengthOfUsername - 1).toUpperCase();

      return Scaffold(
        backgroundColor: const Color.fromARGB(251, 229, 243, 249),
        drawerEnableOpenDragGesture: false,
        key: _key,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.id);
                  },
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      CircleAvatar(
                        //profile picture(later if time permits) or initials
                        radius: 55.0,
                        backgroundColor: Color.fromARGB(
                            245,
                            (lengthOfUsername / (lengthOfUsername - 1) * 10)
                                .toInt(),
                            (lengthOfUsername / (lengthOfUsername - 3) * 50)
                                .toInt(),
                            (lengthOfUsername / (lengthOfUsername - 2) * 95)
                                .toInt()),
                        child: Text(
                          userImageInitials,
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Flexible(child: SizedBox(width: 10)),
                      Text(usernameDisplay),
                    ],
                  ),
                ),
              ),
              //add profile image and user's name here
              ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.id);
                  }),
              ListTile(
                  title: Text('Your Gives'),
                  onTap: () {
                    Navigator.pushNamed(context, YourGivesScreen.id);
                  }),
              ListTile(
                  title: Text('Create A Request'),
                  onTap: () {
                    Navigator.pushNamed(context, CreateRequestScreen.id);
                  }),
              ListTile(
                  title: Text('Current Request'),
                  onTap: () {
                    Navigator.pushNamed(context, CurrentRequestScreen.id);
                  }),
              ListTile(
                  title: Text('Past Requests'),
                  onTap: () {
                    Navigator.pushNamed(context, PastRequestsScreen.id);
                  }),
              SizedBox(
                height: 80.0,
              ),
              ActionButton(
                buttonText: 'Sign Out',
                buttonActionCallback: () {
                  _auth.signOut();

                  Navigator.pushReplacementNamed(context, LandingScreen.id);
                },
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //it is transparent
          shadowColor: Colors.black45,
          scrolledUnderElevation: 1.0,
          elevation: 0.0,
          bottomOpacity: 1.0,
          toolbarOpacity: 1.0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
                // color: Colors.greenAccent,
                ),
            child: Center(
              child: Text(
                'Give Easy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                  // backgroundColor: Colors.greenAccent,
                ),
              ),
            ),
          ),
          leading: //Profile Icon/Pic will come here
              GestureDetector(
            child: Container(
              // color: Colors.greenAccent,
              padding:
                  EdgeInsets.only(bottom: 8.0, right: 8.0, left: 5.0, top: 5.0),
              child: CircleAvatar(
                //profile picture(later if time permits) or initials
                radius: 55.0,
                backgroundColor: Color.fromARGB(
                    245,
                    (lengthOfUsername / (lengthOfUsername - 1) * 10).toInt(),
                    (lengthOfUsername / (lengthOfUsername - 3) * 50).toInt(),
                    (lengthOfUsername / (lengthOfUsername - 2) * 95).toInt()),
                child: Text(
                  userImageInitials,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF00FFA4),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(30.0, 30.0),
                  topRight: Radius.elliptical(30.0, 30.0),
                ),
              ),
            ),
            onTap: () => _key.currentState!.openDrawer(),
          ),
          actions: //Hero animation will come here, it will be the only thing in this list
              [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF00FFA4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(30.0, 30.0),
                  topLeft: Radius.elliptical(30.0, 30.0),
                ),
              ),
              child: Hero(
                tag: 'appIconTransition',
                child: Image.asset('assets/images/handshake.png'),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return listOfAllCategoricalTiles[index];
            }),
            itemCount: listOfAllCategoricalTiles.length,
            padding: EdgeInsets.only(top: 90),
          ),
        ),
      );
    });
  }
}
