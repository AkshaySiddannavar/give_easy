import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:give_easy/constants.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class PhoneNumberEditScreen extends StatefulWidget {
  static const String id = 'phone_number_edit_screen';
  const PhoneNumberEditScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberEditScreen> createState() => _PhoneNumberEditScreenState();
}

class _PhoneNumberEditScreenState extends State<PhoneNumberEditScreen> {
  String phoneNumberTyped = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserData>(
        builder: (context, userDataObject, child) {
          return Scaffold(
            backgroundColor: kGiveEasyGreen,
            appBar: AppBar(
              backgroundColor: kDarkAppBarBackgroundColor,
              title: Text('Phone Number Edit', style: kDarkAppBarTextStyle),
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
                          textFieldLabel: 'Current Phone Number',
                          defaultText:
                              userDataObject.profileData["phoneNumber"],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InputTextField(
                          hintMessage: 'Enter New Phone Number',
                          isSensitive: false,
                          currentTextCallback: (currentText) {
                            phoneNumberTyped = currentText;
                            print(currentText);
                            setState(() {});
                          },
                          textFieldLabel: 'New Phone Number',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ActionButton(
                        isActive: (phoneNumberTyped != null &&
                                phoneNumberTyped.isNotEmpty)
                            ? true
                            : false,
                        buttonText: 'Update Phone Number',
                        buttonActionCallback: () {
                          userDataObject.updatephoneNumber(phoneNumberTyped);
                          FocusScope.of(context)
                              .unfocus(); //To disable keyboard before screen change so that we don't get a overflow exception

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
