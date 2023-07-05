import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddQuestionnairePage extends StatefulWidget {
  const AddQuestionnairePage({Key? key}) : super(key: key);

  @override
  State<AddQuestionnairePage> createState() => _AddQuestionnairePageState();
}

class _AddQuestionnairePageState extends State<AddQuestionnairePage> {

  String Q2selectedValue = "Admin";

  String Q1selectedCategory = "";
  String Q1selectedValue = "";

  List<DropdownMenuItem<String>>? q1DropdownItems;
  List<DropdownMenuItem<String>>? q1QuestionsDropdownItems;

  final RoundedLoadingButtonController _AddEmployeeBtnController = RoundedLoadingButtonController();

  final db = FirebaseFirestore.instance;

  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _loadTravailData();
    Q1selectedValue = await getFirstQuestionFromCategory(Q1selectedCategory);
    await _loadQuestionsForCategory(Q1selectedCategory); // Ajout de cette ligne pour charger les questions

    setState(() {
      // Mettre à jour les états et le widget ici si nécessaire
    });
  }


  Future<void> _loadTravailData() async {
    QuerySnapshot querySnapshot = await db.collection("questionnaires data").get();
    List<DropdownMenuItem<String>> items = [];

    querySnapshot.docs.forEach((doc) {
      String categoryName = doc.id;
      items.add(DropdownMenuItem(
        child: Text(categoryName),
        value: categoryName,
      ));
    });

    setState(() {
      q1DropdownItems = items;
      Q1selectedCategory = items.first.value as String;
    });
  }

  Future<void> _loadQuestionsForCategory(String category) async {
    DocumentSnapshot categorySnapshot =
    await db.collection("questionnaires data").doc(category).get();
    List<DropdownMenuItem<String>> items = [];

    Map<String, dynamic> categoryData =
    categorySnapshot.data() as Map<String, dynamic>;

    categoryData.forEach((key, value) {
      items.add(DropdownMenuItem(
        child: Text(value),
        value: value, // Use the value as the selected value
      ));
    });

    setState(() {
      q1QuestionsDropdownItems = items;
      Q1selectedValue = items.first.value as String; // Update the selected value
    });
  }


  final questionnaire = <String, dynamic>{
    "Answered": 0,
    "Q1": "",
    "Q2": "",
    "Q3": "",
    "Q4": "",
    "Q5": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 30),
                                Text("Add a new questionnaire",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30
                                  ),
                                ),
                                SizedBox(height: 60),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Question 1 :",
                                          style: TextStyle(
                                              fontSize: 17
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        DropdownButton(
                                          value: Q1selectedCategory,
                                          items: q1DropdownItems,
                                          onChanged: (newValue) async {
                                            setState(() {
                                              Q1selectedCategory = newValue!;
                                            });
                                            await _loadQuestionsForCategory(Q1selectedCategory);
                                          },

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                DropdownButton(
                                  value: Q1selectedValue,
                                  items: q1QuestionsDropdownItems,
                                  onChanged: (newValue) {
                                    setState(() {
                                      Q1selectedValue = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Question 2 :",
                                      style: TextStyle(
                                          fontSize: 17
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    DropdownButton(
                                      value: Q2selectedValue ,
                                      items: [
                                        DropdownMenuItem(child: Text("Admin"), value: "Admin"),
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          Q2selectedValue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Date of questionnaire : "+"${selectedDate.toLocal()}".split(' ')[0]),
                                      SizedBox(width: 10.0,),
                                      ElevatedButton(
                                        onPressed: () => _selectDate(context),
                                        child: const Text('Select date'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                RoundedLoadingButton(
                                    child: Text(
                                      'Add the questionnaire',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    color: Colors.redAccent,
                                    controller: _AddEmployeeBtnController,
                                    onPressed: () => _onClickAddQuestionnaireButton()
                                ),
                              ]
                          ),
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
  Future<Map<String, dynamic>> getTravailData() async {
    DocumentSnapshot doc = await db.collection("questionnaires data").doc("travail").get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _onClickAddQuestionnaireButton() {
    questionnaire['Q1'] = getQuestionById(Q1selectedValue);

    db.collection("questionnaires").doc(selectedDate.toString()).set(questionnaire);
  }

  String getQuestionById(String questionId) {
    DocumentReference questionRef = db.collection("questionnaires data").doc(questionId);

    String question = "";

    questionRef.get().then((questionSnapshot) {
      if (questionSnapshot.exists) {
        Map<String, dynamic>? questionData = questionSnapshot.data() as Map<String, dynamic>?;
        if (questionData != null && questionData.containsKey('question')) {
          question = questionData['question'].toString();
        }
      }
    });

    return question;
  }


  Future<String> getFirstQuestionFromCategory(String category) async {
    DocumentSnapshot categorySnapshot = await db.collection("questionnaires data").doc(category).get();
    Map<String, dynamic> categoryData = categorySnapshot.data() as Map<String, dynamic>;
    String firstQuestion = categoryData.values.first.toString();
    return firstQuestion;
  }
}
