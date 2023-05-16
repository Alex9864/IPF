import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:ipf/pages/home/home_page.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({Key? key}) : super(key: key);

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {

  final RoundedLoadingButtonController _finishBtnController = RoundedLoadingButtonController();

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
                RoundedLoadingButton(
                    child: Text(
                      'Finish !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.greenAccent,
                    controller: _finishBtnController,
                    onPressed: () => _onClickFinishButton()
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
  void _onClickFinishButton(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuestionnairePage()
      ),
    );
    HomePage.dailyQuestionnaire = false;
    _finishBtnController.stop();
  }
}
