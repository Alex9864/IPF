import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/forgot%20password/forgot_password_page.dart';
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

  final _EmailFormKey = GlobalKey<FormState>();
  final TextEditingController _EmailTextFormFieldController = TextEditingController();

  final _PasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _PasswordTextFormFieldController = TextEditingController();
  bool _passwordVisible = false;

  final RoundedLoadingButtonController _verifyBtnController = RoundedLoadingButtonController();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            getUserInfos();
            return BottomNavigationBarPage();
          } else {
            return SafeArea(
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
                        key: _EmailFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                          controller: _EmailTextFormFieldController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              hintText: 'Enter your email',
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
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
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
                        child: Text('Sign In', style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                        successColor: Colors.green,
                        controller: _verifyBtnController,
                        onPressed: () => _signIn(),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordPage()
                              )
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _goBack(){
    Navigator.pop(context);
  }

  void getUserInfos(){
    final user = FirebaseAuth.instance.currentUser!;
    final DocumentReference _docRef = db.collection('users').doc(user.email!);

    _docRef.get().then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
        String avatar = data['Avatar'];
        bool firstConnection = data['FirstConnection'];
        String firstName = data['FirstName'];
        String lastName = data['LastName'];
        String role = data['Role'];
        changeUser(avatar, role, firstName, lastName, firstConnection);
      } else {
        // Handle the case where the document does not exist
      }
    });
  }

  Future<void> _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _EmailTextFormFieldController.text, password: _PasswordTextFormFieldController.text);
    getUserInfos();
    _verifyBtnController.stop();
  }

  void changeUser(String Avatar, String Role, String FirstName, String LastName, bool FirstConnection) {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    imageModel.setAvatar(Avatar);
    imageModel.setRole(Role);
    imageModel.setFirstName(FirstName);
    imageModel.setLastName(LastName);
    imageModel.setFirstConnection(FirstConnection);
  }
}
