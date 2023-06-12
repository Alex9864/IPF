import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipf/pages/shared/widgets/action_popup.dart';

class EmployeeCard extends StatelessWidget {
  final String image;
  final String name;
  final int percentage;

  const EmployeeCard({
    Key? key,
    required this.image,
    required this.name,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
                'assets/images/Avatars/'+image+'.png',
                width: 40,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text("Avg :\n"+percentage.toString()+"%",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: mapNumberToColor(percentage)
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ActionPopup();
                },
              );
            },
            child: Text('Suggest an action'),
          )
        ]
      ),
    );
  }

  Color mapNumberToColor(int number) {
    final double ratio = number / 100.0; // Calcule le ratio entre 0.0 et 1.0

    final int red = (255 * (1 - ratio)).round(); // Calcule la valeur de rouge
    final int green = (255 * ratio).round(); // Calcule la valeur de vert
    final int blue = 0; // Valeur de bleu fixée à 0

    return Color.fromRGBO(red, green, blue, 1.0); // Renvoie la couleur correspondante
  }
}
