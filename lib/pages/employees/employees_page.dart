import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/shared/widgets/action_popup.dart';
import 'package:ipf/pages/shared/widgets/employee_card.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
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
                Text("Employees",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                EmployeeCard(image: 'colombe', name: 'Jeanne.P', percentage: 12),
                SizedBox(height: 15),
                EmployeeCard(image: 'renard', name: 'Paul.G', percentage: 15),
                SizedBox(height: 15),
                EmployeeCard(image: 'lelephant', name: 'Pierre.G', percentage: 25),
                SizedBox(height: 15),
                EmployeeCard(image: 'dinosaure', name: 'Charles.R', percentage: 32),
                SizedBox(height: 15),
                EmployeeCard(image: 'lapin', name: 'Mathilde.S', percentage: 33),
                SizedBox(height: 15),
                EmployeeCard(image: 'poisson', name: 'Sylvain.V', percentage: 58),
                SizedBox(height: 15),
                EmployeeCard(image: 'tulipe', name: 'Sylvie.H', percentage: 59),
                SizedBox(height: 15),
                EmployeeCard(image: 'renard', name: 'Ethienne.F', percentage: 62),
                SizedBox(height: 15),
                EmployeeCard(image: 'crabe', name: 'Théo.N', percentage: 67),
                SizedBox(height: 15),
                EmployeeCard(image: 'chauve-souris', name: 'Pierre.A', percentage: 78),
                SizedBox(height: 15),
                EmployeeCard(image: 'star', name: 'Robert.M', percentage: 87),
                SizedBox(height: 15),
                EmployeeCard(image: 'la-grenouille', name: 'Marjorie.O', percentage: 91),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
