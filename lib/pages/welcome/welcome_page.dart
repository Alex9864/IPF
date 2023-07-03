import 'package:ipf/pages/auth/authtentification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final RoundedLoadingButtonController _getStartedBtnController = RoundedLoadingButtonController();

  String _selected = '2';
  List<Map> _flags = [
    {
      'id': '1',
      'image': 'assets/images/flags/france.png'
    },
    {
      'id': '2',
      'image': 'assets/images/flags/royaume-uni.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: _selected,
                        onChanged: (newValue) {
                          setState(() {
                            _selected = newValue!;
                          });
                        },
                        items: _flags.map((Item) {
                          return DropdownMenuItem(
                            value: Item['id'].toString(),
                            child: Image.asset(Item['image'], width: 30)
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ),
                Image.asset(
                  'assets/images/Logo_Peace_Meter.png',
                  height: 300,
                ),
                SizedBox(height: 30),
                Text("Welcome to Peace Meter !",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25
                ),),
                SizedBox(height: 10),
                Text("Employee's health is our priority",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 15
                ),),
                SizedBox(height: 30),
                RoundedLoadingButton(
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  successColor: Colors.green,
                  controller: _getStartedBtnController,
                  onPressed: () => _onClickGetStartedButton(),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onClickGetStartedButton(){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => const AuthenticationPage()
          // builder: (context) => const BottomNavigationBarPage()
      )
    );
    _getStartedBtnController.stop();
  }
}
