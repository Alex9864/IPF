import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../otp/otp_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _textFieldFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberTextFormFieldController = TextEditingController();
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
                GestureDetector(
                  onTap: () => _goBack(),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(height: 30),
                Text("Verified your phone number",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Form(
                    key: _textFieldFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      autofocus: true,
                      controller: _phoneNumberTextFormFieldController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone_android),
                          hintText: "0610101010",
                          labelText: "Your phone number"
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 14,
                    )
                ),
                SizedBox(height: 30),
                RoundedLoadingButton(
                  child: Text('Send code', style: TextStyle(color: Colors.white)),
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
    if(_textFieldFormKey.currentState!.validate()){
      if(_phoneNumberTextFormFieldController.text.isNotEmpty){
        String phoneNumber = "+33${_phoneNumberTextFormFieldController.text}";

        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => OtpPage(
                        phoneNumber: phoneNumber,
                        verificationId: verificationId,
                        resendToken: resendToken!
                    )
                )
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        _verifyBtnController.stop();
      } else {
        _verifyBtnController.stop();
      }
    } else {
      _verifyBtnController.stop();
    }
  }
}
