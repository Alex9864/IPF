import 'package:ipf/pages/home/home_page.dart';
import 'package:ipf/pages/portfolio/portfolio_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile/profile_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  
  int _pageSelectedIndex = 0;
  
  List<Widget> _bottomNavigationBarWidgets = <Widget>[
    const HomePage(),
    const PortfolioPage(),
    const ProfilePage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _bottomNavigationBarWidgets.elementAt(_pageSelectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Portfolio"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Profil"
          ),
        ],
        currentIndex: _pageSelectedIndex,
        selectedItemColor: _selectedItemColor(),
        onTap: (value) => _onItemSelected(value),
      ),
    );
  }
  
  void _onItemSelected(int index){
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  Color _selectedItemColor (){
    if(_pageSelectedIndex == 0){
      return Colors.blue;
    } else if(_pageSelectedIndex == 1){
      return Colors.pinkAccent;
    } else {
      return Colors.orangeAccent;
    }
  }
}
