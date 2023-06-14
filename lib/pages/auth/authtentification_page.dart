import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/navigation_bar/bottom_navigation_bar_page.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../otp/otp_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final _LoginFormKey = GlobalKey<FormState>();
  final TextEditingController _LoginTextFormFieldController = TextEditingController();

  final _PasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _PasswordTextFormFieldController = TextEditingController();
  bool _passwordVisible = false;

  final RoundedLoadingButtonController _verifyBtnController = RoundedLoadingButtonController();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _goBack(),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(height: 30),
                Text("Connect to your account",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("An administrator must have sent you your informations.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Form(
                    key: _LoginFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: _LoginTextFormFieldController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person_outline),
                          labelText: "Login",
                          hintText: 'Enter your login',
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                    )
                ),
                SizedBox(height: 10),
                Form(
                    key: _PasswordFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: _PasswordTextFormFieldController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_open),
                        labelText: "Password",
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                    )
                ),
                SizedBox(height: 30),
                RoundedLoadingButton(
                  child: Text('Verify', style: TextStyle(color: Colors.white)),
                  color: Colors.redAccent,
                  successColor: Colors.green,
                  controller: _verifyBtnController,
                  onPressed: () => _sendOtpCodeWithFirebase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goBack(){
    Navigator.pop(context);
  }

  void _sendOtpCodeWithFirebase() async {
    if(_LoginFormKey.currentState!.validate()){
      final QuerySnapshot result = await db.collection('users').where('Login', isEqualTo: _LoginTextFormFieldController.text).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length > 0) { // If Login exists
        if(_PasswordFormKey.currentState!.validate()){
          final data = documents[0].data() as Map<String, dynamic>;
          final password = data['Password'];
          if(_PasswordTextFormFieldController.text == password ){
            final Avatar = data['Avatar'];
            final Role = data['Role'];
            final FirstName = data['FirstName'];
            final LastName = data['LastName'];
            final Login = data['Login'];
            changeUser(Avatar, Role, FirstName, LastName, Login);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BottomNavigationBarPage()
              )
            );
            _verifyBtnController.stop();
          } else {
            print("Wrong password");
            _verifyBtnController.stop();
          }
        } else {
          print("You must enter a valid password");
          _verifyBtnController.stop();
        }
        _verifyBtnController.stop();
      } else {
        print("No account found with this login");
        _verifyBtnController.stop();
      }
    } else {
      print("You must enter a valid login");
      _verifyBtnController.stop();
    }
  }

  void changeUser(String Avatar, String Role, String FirstName, String LastName, String Login) {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    imageModel.setAvatar(Avatar);
    imageModel.setRole(Role);
    imageModel.setFirstName(FirstName);
    imageModel.setLastName(LastName);
    imageModel.setLogin(Login);
  }
}
