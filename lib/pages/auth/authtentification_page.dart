import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/navigation_bar/bottom_navigation_bar_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../otp/otp_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _LoginFormKey = GlobalKey<FormState>();
  final _PasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _LoginTextFormFieldController = TextEditingController();
  final TextEditingController _PasswordTextFormFieldController = TextEditingController();
  final RoundedLoadingButtonController _verifyBtnController = RoundedLoadingButtonController();
  bool _passwordVisible = false;

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
      if(_LoginTextFormFieldController.text == "LoginTest"){
        if(_PasswordFormKey.currentState!.validate()){
          if(_PasswordTextFormFieldController.text == "PasswordTest"){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BottomNavigationBarPage()
              )
            );
            _verifyBtnController.stop();
          } else {
            _verifyBtnController.stop();
          }
        } else {
          _verifyBtnController.stop();
        }
        _verifyBtnController.stop();
      } else {
        _verifyBtnController.stop();
      }
    } else {
      _verifyBtnController.stop();
    }



  }

  // void _sendOtpCodeWithFirebase() async {
  //   if(_PhoneFormKey.currentState!.validate()){
  //     if(_phoneNumberTextFormFieldController.text.isNotEmpty){
  //       String phoneNumber = "+33${_phoneNumberTextFormFieldController.text}";
  //
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: (PhoneAuthCredential credential) {},
  //         verificationFailed: (FirebaseAuthException e) {
  //           if (e.code == 'invalid-phone-number') {
  //             print('The provided phone number is not valid.');
  //           }
  //         },
  //         codeSent: (String verificationId, int? resendToken) {
  //           Navigator.pop(context);
  //           Navigator.of(context).push(
  //               MaterialPageRoute(
  //                   builder: (context) => OtpPage(
  //                       phoneNumber: phoneNumber,
  //                       verificationId: verificationId,
  //                       resendToken: resendToken!
  //                   )
  //               )
  //           );
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {},
  //       );
  //       _verifyBtnController.stop();
  //     } else {
  //       _verifyBtnController.stop();
  //     }
  //   } else {
  //     _verifyBtnController.stop();
  //   }
  //   if(_NameFormKey.currentState!.validate()){
  //     if(_NameTextFormFieldController.text.isNotEmpty){
  //       //Code
  //       _verifyBtnController.stop();
  //     } else {
  //       _verifyBtnController.stop();
  //     }
  //   } else {
  //     _verifyBtnController.stop();
  //   }
  //   if(_SurnameFormKey.currentState!.validate()){
  //     if(_SurnameTextFormFieldController.text.isNotEmpty){
  //       //Code
  //       _verifyBtnController.stop();
  //     } else {
  //       _verifyBtnController.stop();
  //     }
  //   } else {
  //     _verifyBtnController.stop();
  //   }
  //   if(_MailFormKey.currentState!.validate()){
  //     if(_MailTextFormFieldController.text.isNotEmpty){
  //       //Code
  //       _verifyBtnController.stop();
  //     } else {
  //       _verifyBtnController.stop();
  //     }
  //   } else {
  //     _verifyBtnController.stop();
  //   }
  // }
}
