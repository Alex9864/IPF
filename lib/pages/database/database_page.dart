import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/database/add_database.dart';
import 'package:ipf/pages/database/add_questionnaire.dart';
import 'package:ipf/pages/shared/widgets/employee_card_db.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({Key? key}) : super(key: key);

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {

  List<Map<String, dynamic>> filteredUsers = [];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddDatabasePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Add an employee'), // Texte du bouton
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search employees by first name',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      // Convertir les documents Firestore en une liste de Map
                      List<Map<String, dynamic>> users = snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return {
                          'documentId': document.id,
                          ...data,
                        };
                      }).toList();

                      // Filtrer les utilisateurs en fonction du texte de recherche
                      if (searchQuery.isNotEmpty) {
                        filteredUsers = users.where((user) {
                          String firstName = user['FirstName'].toString().toLowerCase();
                          return firstName.contains(searchQuery.toLowerCase());
                        }).toList();
                      } else {
                        // Si la recherche est vide, afficher tous les utilisateurs
                        filteredUsers = users;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.redAccent,
                              width: 5,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: new ListView(
                            children: filteredUsers.map((user) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    EmployeeCardDB(
                                      avatar: user['Avatar'],
                                      firstname: user['FirstName'],
                                      lastname: user['LastName'],
                                      role: user['Role'],
                                      email: user['documentId'],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddQuestionnairePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Add a questionnaire'), // Texte du bouton
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('questionnaires').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.redAccent,
                              width: 5,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: new ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.yellow,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(document.id),
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ]
              ),
            )
          )
        )
      )
    );
  }
}
