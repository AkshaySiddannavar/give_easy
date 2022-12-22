import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class EmailEditScreen extends StatefulWidget {
  static const String id = 'email_edit_screen';
  const EmailEditScreen({Key? key}) : super(key: key);

  @override
  State<EmailEditScreen> createState() => _EmailEditScreenState();
}

class _EmailEditScreenState extends State<EmailEditScreen> {
  String emailTyped = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserData>(
        builder: (context, userDataObject, child) {
          return Scaffold(
            backgroundColor: Color(0xFF00FFA4),
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Email Edit',
                style: TextStyle(
                  color: Color(0xFF00FFA4),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
                          textFieldLabel: 'Current Email',
                          defaultText: userDataObject.profileData["userEmail"],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InputTextField(
                          hintMessage: 'Enter New Email',
                          isSensitive: false,
                          currentTextCallback: (currentText) {
                            emailTyped = currentText;
                            print(currentText);
                            setState(() {});
                          },
                          textFieldLabel: 'New Email',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ActionButton(
                        buttonColor: Colors.black,
                        textColor: Color(0xFF00FFA4),
                        isActive: (emailTyped != null && emailTyped.isNotEmpty)
                            ? true
                            : false,
                        buttonText: 'Update Email',
                        buttonActionCallback: () {
                          userDataObject.updateUserEmail(emailTyped);
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
