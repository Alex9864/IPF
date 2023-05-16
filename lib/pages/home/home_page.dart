import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:ipf/pages/questionnaire/questionnaire_page.dart';
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

  var now = new DateTime.now();
  var formatter = new DateFormat.yMMMMEEEEd('en_US');

  @override
  Widget build(BuildContext context) {

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
                    IconButton(
                        onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://picsum.photos/seed/353/600',
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  'Welcome [USER]',
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
                if (!HomePage.dailyQuestionnaire) ...[
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
                ],
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
}
