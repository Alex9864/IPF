import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../navigation_bar/bottom_navigation_bar_page.dart';

class OtpPage extends StatefulWidget {

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _textFieldFormKey = GlobalKey<FormState>();
  final TextEditingController _otpCodeTextFormFieldController = TextEditingController();
  final RoundedLoadingButtonController _verifyBtnController = RoundedLoadingButtonController();

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
                SizedBox(
                  height: 40,
                ),
                Text("Verify your email address",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("We've sent you a verification code to your email address.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("Please put the code you recieved below.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Form(
                    key: _textFieldFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      autofocus: true,
                      controller: _otpCodeTextFormFieldController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail_outline),
                          hintText: "000000",
                          labelText: "Your verification code"
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    )
                ),
                SizedBox(height: 30),
                RoundedLoadingButton(
                  child: Text('Verify', style: TextStyle(color: Colors.white)),
                  color: Colors.redAccent,
                  successColor: Colors.green,
                  controller: _verifyBtnController,
                  onPressed: () => _verifyPhoneNumberInFirebase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumberInFirebase() async {
    if(_otpCodeTextFormFieldController.text.isNotEmpty){

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarPage()
        )
      );

      // try {
      //   PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
      //       verificationId: widget.verificationId,
      //       smsCode: _otpCodeTextFormFieldController.text
      //   );
      //
      //   // -- Sign with credential if
      //   await FirebaseAuth.instance.signInWithCredential(authCredential);
      //
      //   Navigator.pop(context);
      //   Navigator.of(context).push(
      //       MaterialPageRoute(
      //           builder: (context) => const BottomNavigationBarPage()
      //       )
      //   );
      //
      // } on FirebaseAuthException {
      //   print("Code OTP expiré ou invalide");
      //   _verifyBtnController.stop();
      // }

    } else {
      _verifyBtnController.stop();
    }
  }
}
