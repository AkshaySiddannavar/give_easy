import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class UsernameEditScreen extends StatefulWidget {
  static const String id = 'username_edit_screen';
  const UsernameEditScreen({Key? key}) : super(key: key);

  @override
  State<UsernameEditScreen> createState() => _UsernameEditScreenState();
}

class _UsernameEditScreenState extends State<UsernameEditScreen> {
  //using provider package to load all user's data
  String usernameTyped = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<userData>(
        builder: (context, userDataObject, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Username Edit'),
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
                          textFieldLabel: 'Current Username',
                          defaultText: userDataObject.profileData["userName"],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InputTextField(
                          hintMessage: 'Enter New Username',
                          isSensitive: false,
                          currentTextCallback: (currentText) {
                            usernameTyped = currentText;
                            print(currentText);
                            setState(() {});
                          },
                          textFieldLabel: 'New Username',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ActionButton(
                        isActive:
                            (usernameTyped != null && usernameTyped.isNotEmpty)
                                ? true
                                : false,
                        buttonText: 'Update Username',
                        buttonActionCallback: () {
                          userDataObject.updateUsername(usernameTyped);
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
