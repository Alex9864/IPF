import 'package:ipf/pages/database/database_page.dart';
import 'package:ipf/pages/employees/employees_page.dart';
import 'package:ipf/pages/home/home_page.dart';
import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/notifications/notifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/view%20questionnaires/view_questionnaires.dart';
import 'package:ipf/pages/my%20statistics/my_statistics.dart';
import 'package:ipf/pages/wip/wip_page.dart';
import 'package:provider/provider.dart';

import '../profile/profile_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _pageSelectedIndex = 0;

  List<Widget> _userNavigationItems = <Widget>[
    HomePage(),
    MyStatisticsPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  List<Widget> _adminNavigationItems = <Widget>[
    HomePage(),
    const ViewQuestionnairesPage(),
    const EmployeesPage(),
    const ProfilePage(),
    DatabasePage(),
  ];

  @override
  Widget build(BuildContext context) {

    String role = Provider.of<ImageModel>(context).role;

    List<Widget> navigationItems =
    role == "User" ? _userNavigationItems : _adminNavigationItems;

    return Scaffold(
      body: Center(
        child: navigationItems.elementAt(_pageSelectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: role == "User" ? Icon(Icons.calendar_month) : Icon(Icons.question_mark),
            label: role == "User" ? "My statistics" : "Questionnaires",
          ),
          BottomNavigationBarItem(
            icon: role == "User" ? Icon(Icons.notifications) : Icon(Icons.work),
            label: role == "User" ? "Notifications" : "Employees",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profil",
          ),
          if (role == "Admin") // Condition pour afficher le bouton supplémentaire pour le rôle admin
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: "Database",
            ),
        ],
        currentIndex: _pageSelectedIndex,
        unselectedItemColor: Colors.orangeAccent,
        selectedItemColor: Colors.deepOrange,
        onTap: (value) => _onItemSelected(value),
      ),
    );
  }

  void _onItemSelected(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  // Color _selectedItemColor() {
  //   if (_pageSelectedIndex == 0) {
  //     return Colors.deepOrangeAccent;
  //   } else if (_pageSelectedIndex == 1) {
  //     return Colors.deepOrangeAccent;
  //   } else if (_pageSelectedIndex == 2) {
  //     return Colors.deepOrangeAccent;
  //   } else {
  //     return Colors.deepOrangeAccent;
  //   }
  // }
}
