import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewQuestionnairesPage extends StatefulWidget {
  const ViewQuestionnairesPage({Key? key}) : super(key: key);

  @override
  State<ViewQuestionnairesPage> createState() => _ViewQuestionnairesPageState();
}

class _ViewQuestionnairesPageState extends State<ViewQuestionnairesPage> {
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
                Text("View Questionnaires",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
  void _goBack(){
    Navigator.pop(context);
  }
}
