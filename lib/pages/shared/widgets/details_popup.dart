import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Details"),
      content: Container(
        width: double.maxFinite, // Utilise toute la largeur disponible
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Comment vous sentez vous ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: 0 == index,
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  'Est-ce que vous trouvez votre travail intéressant et stimulant ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: 1 == index,
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  'Avez-vous de bonnes relations avec vos collègues et vos supérieurs ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(6,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['1', '2', '3', '4', '5', '6'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: 0 == index,
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  "Avez-vous des suggestions pour améliorer l'environnement de travail ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lightbulb),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  readOnly: true,
                  controller: TextEditingController()..text = "J'aimerais vraiment que quelque chose soit fait au sujet de...",
                ),
                SizedBox(height: 20),
                Text(
                  "Rendre mes réponses anonyme",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(2,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['Oui', 'Non'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: 1 == index,
                      ),
                    );
                  },
                  ).toList(),
                ),
              ]
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajustez les valeurs selon vos besoins
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Suggest an action"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    );
  }
}