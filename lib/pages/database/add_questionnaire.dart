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

  String Q1selectedValue = "User";
  String Q2selectedValue = "User";

  final RoundedLoadingButtonController _AddEmployeeBtnController = RoundedLoadingButtonController();

  final db = FirebaseFirestore.instance;

  DateTime selectedDate = DateTime.now();


  List<DropdownMenuItem<String>>? q1DropdownItems;

  @override
  void initState() {
    super.initState();
    _loadTravailData();
  }

  void _loadTravailData() async {
    Map<String, dynamic> travailData = await getTravailData();
    List<DropdownMenuItem<String>> items = [];

    travailData.forEach((key, value) {
      items.add(DropdownMenuItem(
        child: Text(value),
        value: value,
      ));
    });

    setState(() {
      q1DropdownItems = items;
    });
  }

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
                                      value: Q1selectedValue,
                                      items: q1DropdownItems,
                                      onChanged: (newValue) {
                                        setState(() {
                                          Q1selectedValue = newValue!;
                                        });
                                      },
                                    )
                                  ],
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
                                        DropdownMenuItem(child: Text("User"),value: "User"),
                                        DropdownMenuItem(child: Text("Admin"),value: "Admin"),
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
    DocumentSnapshot doc = await db.collection("questionnaires_data").doc("travail").get();
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

  void _onClickAddQuestionnaireButton(){

  }
}
