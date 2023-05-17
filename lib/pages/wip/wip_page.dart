import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WipPage extends StatefulWidget {
  const WipPage({Key? key}) : super(key: key);

  @override
  State<WipPage> createState() => _WipPageState();
}

class _WipPageState extends State<WipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Wip',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
