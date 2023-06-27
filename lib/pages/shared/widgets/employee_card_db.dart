import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/shared/widgets/action_popup.dart';

class EmployeeCardDB extends StatelessWidget {
  final String avatar;
  final String firstname;
  final String lastname;
  final String role;
  final String email;

  const EmployeeCardDB({
    Key? key,
    required this.avatar,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/Avatars/'+avatar+'.png',
            width: 40,
            fit: BoxFit.contain,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(firstname,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
              Text(lastname,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(role,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
            ),
            textAlign: TextAlign.center,
          ),
          if (role != "Admin")...[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ActionPopup();
                      },
                    );
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteUser();
                  },
                  child: Text('Delete'),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
  void deleteUser(){

  }
}
