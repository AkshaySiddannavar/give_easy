import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class GenderEditScreen extends StatefulWidget {
  static const String id = 'gender_edit_screen';
  const GenderEditScreen({Key? key}) : super(key: key);

  @override
  State<GenderEditScreen> createState() => _GenderEditScreenState();
}

class _GenderEditScreenState extends State<GenderEditScreen> {
  String selectedGender = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserData>(
        builder: (context, userDataObject, child) {
          return Scaffold(
            backgroundColor: kGiveEasyGreen,
            appBar: AppBar(
              backgroundColor: kDarkAppBarBackgroundColor,
              title: Text('Gender Edit', style: kDarkAppBarTextStyle),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Form(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InputTextField(
                          isReadOnly: true,
                          hintMessage: '',
                          isSensitive: false,
                          currentTextCallback: (currentText) {},
                          textFieldLabel: 'Current Gender',
                          defaultText: userDataObject.profileData["gender"],
                        ),
                      ),
                    ),
                    Text(
                      'Select Your Gender',
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 3.0,
                                vertical: 5.0,
                              ),
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                'Male',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (maleSelected) {
                                selectedGender = maleSelected.toString();
                                print(maleSelected);
                                setState(() {});
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 5.0),
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                'Female',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (femaleSelected) {
                                selectedGender = femaleSelected.toString();
                                print(femaleSelected);
                                setState(() {});
                              }),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 5.0),
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                'Other',
                                style: TextStyle(fontSize: 15),
                              ),
                              value: 'Other',
                              groupValue: selectedGender,
                              onChanged: (otherSelected) {
                                selectedGender = otherSelected.toString();
                                print(otherSelected);
                                setState(() {});
                              }),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 10.0,
                      ),
                    ),
                    ActionButton(
                        isActive: (selectedGender != null &&
                                selectedGender.isNotEmpty)
                            ? true
                            : false,
                        buttonText: 'Update Gender',
                        buttonActionCallback: () {
                          userDataObject.updateGender(selectedGender);
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
