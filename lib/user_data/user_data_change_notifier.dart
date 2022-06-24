import 'package:flutter/material.dart';
import 'package:give_easy/user_data/user_data_firestore_api.dart';

class UserData extends ChangeNotifier {
  late Map<dynamic, dynamic> profileData; //Data to be exposed using provider

  UserData() {
    profileData = {
      "gender": 'Loading...',
      "organizationName": 'Loading...',
      "phoneNumber": 'Loading...',
      "userEmail": 'Loading...',
      "userName": 'Loading...',
      "uniqueID": 'Loading...',
      "documentID": 'Loading...',
    };
  }

  void updateFullProfile() async {
    profileData = await UserDataFirestoreAPI.readDBUserData();
    print('************\n\nUPDATE FULL PROFILE\n\n*****************');
    notifyListeners();
  }

  void updateGender(String newGender) {
    //updates have to be made here and also in API class because we expose data to provider from here
    profileData["gender"] = newGender;
    //We only need to update "gender" field and not others
    UserDataFirestoreAPI.updateDBGender(newGender);

    notifyListeners();
  }

  void updateOrganizationName(String newOrganization) {
    profileData["organizationName"] = newOrganization;

    UserDataFirestoreAPI.updateDBOrganizationName(newOrganization);
    notifyListeners();
  }

  void updatephoneNumber(String newPhoneNumber) {
    profileData["phoneNumber"] = newPhoneNumber;

    UserDataFirestoreAPI.updateDBphoneNumber(newPhoneNumber);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    profileData["userEmail"] = newEmail;

    UserDataFirestoreAPI.updateDBUserEmail(newEmail);
    notifyListeners();
  }

  void updateUsername(String newUsername) {
    profileData["userName"] =
        newUsername; //setting new username locally so all screens usiing this provider will get this data updated then and there

    //We only need to update "userName" field and not others

    UserDataFirestoreAPI.updateDBUsername(newUsername);

    notifyListeners();
  }
}
