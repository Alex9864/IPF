import 'package:ipf/pages/home/home_page.dart';
import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/portfolio/portfolio_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/view%20questionnaires/view_questionnaires.dart';
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
    const ViewQuestionnairesPage(),
    const ProfilePage(),
  ];

  List<Widget> _adminNavigationItems = <Widget>[
    HomePage(),
    const ViewQuestionnairesPage(),
    const ProfilePage(),
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
            icon: Icon(Icons.account_circle),
            label: "Profil",
          ),
        ],
        currentIndex: _pageSelectedIndex,
        selectedItemColor: _selectedItemColor(),
        onTap: (value) => _onItemSelected(value),
      ),
    );
  }

  void _onItemSelected(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  Color _selectedItemColor() {
    if (_pageSelectedIndex == 0) {
      return Colors.blue;
    } else if (_pageSelectedIndex == 1) {
      return Colors.pinkAccent;
    } else {
      return Colors.orangeAccent;
    }
  }
}
