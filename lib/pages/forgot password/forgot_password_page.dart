import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _EmailFormKey = GlobalKey<FormState>();
  final TextEditingController _EmailTextFormFieldController = TextEditingController();

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
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(height: 70),
                Text("Enter your email so we can send you informations on how to reset your password.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 90),
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
                SizedBox(height: 30),
                RoundedLoadingButton(
                  child: Text('Reset Password', style: TextStyle(color: Colors.white)),
                  color: Colors.redAccent,
                  successColor: Colors.green,
                  controller: _verifyBtnController,
                  onPressed: () => _resetPassword(),
                ),
              ]
            )
          )
        )
      )
    );
  }

  Future<void> _resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _EmailTextFormFieldController.text);
    _verifyBtnController.stop();
  }
}
