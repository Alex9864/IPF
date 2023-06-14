import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/navigation_bar/bottom_navigation_bar_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:ipf/pages/home/home_page.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({Key? key}) : super(key: key);

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {

  final TextEditingController _SuggestionsTextFormFieldController = TextEditingController();
  final RoundedLoadingButtonController _finishBtnController = RoundedLoadingButtonController();

  int? _choice = 1;
  int? _choice2 = 1;
  int? _choice3 = 1;
  int? _choice4 = 1;

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
                Text("Questionnaire",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  'Comment vous sentez vous ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  'Est-ce que vous trouvez votre travail intéressant et stimulant ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice2 == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice2 = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  'Avez-vous de bonnes relations avec vos collègues et vos supérieurs ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice3 == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice3 = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  "Rendre mes réponses anonyme",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(2,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['Oui', 'Non'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice4 == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice4 = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
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
        builder: (context) => const BottomNavigationBarPage()
      ),
    );
    HomePage.dailyQuestionnaire = false;
    _finishBtnController.stop();
  }

  void _goBack(){
    Navigator.pop(context);
  }
}
