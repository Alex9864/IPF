import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/shared/widgets/details_popup.dart';

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
                SizedBox(height: 20),
                Text("View Questionnaires",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DetailsPopup();
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/Avatars/colombe.png',
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Text("Jeanne.P",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.green
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.check, color: Colors.green,)
                              ],
                            ),
                            Text("Avg :\n1.23/6",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.red
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DetailsPopup();
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/Avatars/renard.png',
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Text("Paul.G",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.green
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.check, color: Colors.green,)
                              ],
                            ),
                            Text("Avg :\n2.70/6",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.orange
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DetailsPopup();
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/Avatars/question_mark.png',
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Text("Anonymous",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.green
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.check, color: Colors.green,)
                              ],
                            ),
                            Text("Avg :\n5.56/6",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.green
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DetailsPopup();
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/Avatars/question_mark.png',
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Text("Anonymous",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.green
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.check, color: Colors.green,)
                              ],
                            ),
                            Text("Avg :\n4.97/6",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.green
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[350],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("23 people did not answer yet",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          Icon(CupertinoIcons.clock_fill)
                        ]
                      )
                    )
                  ],
                ),
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
