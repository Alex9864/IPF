import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:math';

class AddDatabasePage extends StatefulWidget {
  const AddDatabasePage({Key? key}) : super(key: key);

  @override
  State<AddDatabasePage> createState() => _AddDatabasePageState();
}

class _AddDatabasePageState extends State<AddDatabasePage> {

  String selectedValue = "User";

  final _EmailFormKey = GlobalKey<FormState>();
  final TextEditingController _EmailTextFormFieldController = TextEditingController();

  final _FirstNameFormKey = GlobalKey<FormState>();
  final TextEditingController _FirstNameTextFormFieldController = TextEditingController();

  final _LastNameFormKey = GlobalKey<FormState>();
  final TextEditingController _LastNameTextFormFieldController = TextEditingController();

  final RoundedLoadingButtonController _AddEmployeeBtnController = RoundedLoadingButtonController();

  final db = FirebaseFirestore.instance;

  final user = <String, dynamic>{
    "Avatar": "chauve-souris",
    "FirstName": "",
    "LastName": "",
    "Role": "",
    "FirstConnection": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text("Add a new employee",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30
                        ),
                      ),
                      SizedBox(height: 60),
                      Form(
                          key: _EmailFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: _EmailTextFormFieldController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              hintText: 'Enter their email address',
                            ),
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                          )
                      ),
                      SizedBox(height: 20,),
                      Form(
                        key: _FirstNameFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: _FirstNameTextFormFieldController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outline),
                            labelText: "First Name",
                            hintText: 'Enter their first name',
                          ),
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                        )
                      ),
                      SizedBox(height: 20,),
                      Form(
                        key: _LastNameFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: _LastNameTextFormFieldController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outline),
                            labelText: "Last Name",
                            hintText: 'Enter their last name',
                          ),
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                        )
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Role :",
                            style: TextStyle(
                                fontSize: 17
                            ),
                          ),
                          SizedBox(width: 10),
                          DropdownButton(
                            value: selectedValue ,
                            items: [
                              DropdownMenuItem(child: Text("User"),value: "User"),
                              DropdownMenuItem(child: Text("Admin"),value: "Admin"),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      RoundedLoadingButton(
                        child: Text(
                          'Add the employee',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        color: Colors.redAccent,
                        controller: _AddEmployeeBtnController,
                        onPressed: () => _onClickAddEmployeeButton()
                      ),
                    ]
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }
  Future<void> _onClickAddEmployeeButton() async {

    Random random = Random();
    String randomNumbers = '';
    for (int i = 0; i < 5; i++) {
      int randomNumber = random.nextInt(10);
      randomNumbers += '$randomNumber';
    }
    String firstName = _FirstNameTextFormFieldController.text.trim();
    String lastName = _LastNameTextFormFieldController.text.trim();
    String email = _EmailTextFormFieldController.text.trim();
    user['FirstName'] = firstName;
    user['LastName'] = lastName;
    user['Role'] = selectedValue;
    db.collection("users").doc(email).set(user);

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: firstName.substring(0, 1).toUpperCase() + lastName.substring(0, 1).toUpperCase() + randomNumbers);
    _AddEmployeeBtnController.stop();
    Navigator.pop(context);
  }

  void deleteAccount(String uid) async {
    // try {
    //   await FirebaseAdmin.instance.auth().deleteUser(uid);
    //   print('Compte utilisateur supprimé avec succès !');
    // } catch (e) {
    //   print('Erreur lors de la suppression du compte utilisateur : $e');
    // }
  }
}
