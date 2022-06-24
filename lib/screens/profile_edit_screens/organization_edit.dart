import 'package:flutter/material.dart';
import 'package:give_easy/components/action_button.dart';
import 'package:give_easy/components/input_text_field.dart';
import 'package:give_easy/user_data/user_data_change_notifier.dart';
import 'package:provider/provider.dart';

class OrganizationEditScreen extends StatefulWidget {
  static const String id = 'organization_edit_screen';
  const OrganizationEditScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationEditScreen> createState() => _OrganizationEditScreenState();
}

class _OrganizationEditScreenState extends State<OrganizationEditScreen> {
  String organizationTyped = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserData>(
        builder: (context, userDataObject, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Organization Name Edit'),
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
                          textFieldLabel: 'Current Organization Name',
                          defaultText: (userDataObject
                                      .profileData["organizationName"] ==
                                  '')
                              ? 'NO ORGANIZATION'
                              : userDataObject.profileData["organizationName"],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InputTextField(
                          hintMessage: 'Enter New Organization Name',
                          isSensitive: false,
                          currentTextCallback: (currentText) {
                            organizationTyped = currentText;
                            print(currentText);
                            setState(() {});
                          },
                          textFieldLabel: 'New Organization Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ActionButton(
                        isActive: (organizationTyped != null &&
                                organizationTyped.isNotEmpty)
                            ? true
                            : false,
                        buttonText: 'Update Organization Name',
                        buttonActionCallback: () {
                          userDataObject
                              .updateOrganizationName(organizationTyped);
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
