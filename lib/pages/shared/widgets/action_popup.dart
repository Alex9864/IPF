import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Suggest an action"),
      content: Container(
        width: double.maxFinite, // Utilise toute la largeur disponible
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lightbulb),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: TextEditingController()..text = "",
              ),
            ]
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajustez les valeurs selon vos besoins
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Send"),
        ),
      ],
    );
  }
}