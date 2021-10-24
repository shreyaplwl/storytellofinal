import 'package:flutter/material.dart';
import 'package:storify/authentication/custom_colors.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   'assets/LOGO STORY TELLO.png',
        //   height: 20,
        // ),
        // SizedBox(width: 8),
        Text(
          'Storytello',
          style: TextStyle(
            color: CustomColors.firebaseYellow,
            fontSize: 18,
          ),
        ),
        Text(
          ' Authentication',
          style: TextStyle(
            color: CustomColors.firebaseOrange,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
