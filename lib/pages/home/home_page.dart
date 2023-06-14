import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/profile/profile_page.dart';
import 'package:ipf/pages/questionnaire/questionnaire_page.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../shared/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  static bool dailyQuestionnaire = false;
HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final RoundedLoadingButtonController _startQuestionnaireBtnController = RoundedLoadingButtonController();
  final db = FirebaseFirestore.instance;
  var now = new DateTime.now();
  var formatter = new DateFormat.yMMMMEEEEd('en_US');

  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

  @override
  Widget build(BuildContext context) {

    String avatar = Provider.of<ImageModel>(context).avatar;
    String role = Provider.of<ImageModel>(context).role;
    String firstName = Provider.of<ImageModel>(context).firstName;

    String formattedDate = formatter.format(now);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Role : ' + role,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Avatars/'+ avatar + '.png',
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  'Welcome ' + firstName,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 4,
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Dashboard',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Icon(
                      Icons.tune,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                if (role == "User") ...[
                  RoundedLoadingButton(
                      child: Text(
                        'Start my daily questionnaire !',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      color: Colors.redAccent,
                      controller: _startQuestionnaireBtnController,
                      onPressed: () => _onClickStartQuestionnaireButton()
                  ),
                  Text(
                    '[Things to do to get better]',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]else...[
                  Text(
                    '[Stats of daily questionnaires]',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 20),
                RoundedLoadingButton(
                    child: Text(
                      'Test Button',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    color: Colors.redAccent,
                    controller: _startQuestionnaireBtnController,
                    onPressed: () => _onClickTestButton()
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  void _onClickStartQuestionnaireButton(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const QuestionnairePage()
        )
    );
    _startQuestionnaireBtnController.stop();
  }

  void _onClickTestButton(){
    db.collection("users").add(user).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
    _startQuestionnaireBtnController.stop();
  }
}
