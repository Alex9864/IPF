import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double paddingWidth;
  final String title;
  final bool hasBackground;
  final Widget page;

  const CustomButton({
    Key? key,
    required this.paddingWidth,
    required this.title,
    required this.hasBackground,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2
        ),
        color: hasBackground ? Colors.black : Colors.transparent
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: paddingWidth),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: hasBackground ? Colors.white : Colors.black
          ),
        ),
      ),
    );
  }
}
