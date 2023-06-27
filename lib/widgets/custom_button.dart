import 'package:flutter/material.dart';

import '../utilities/app_color.dart';

class CustomButton extends StatelessWidget {
  Color btnColor;
  String title;
  Function btnTap;
  CustomButton(
      {super.key,
      required this.btnColor,
      required this.title,
      required this.btnTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          btnTap();
        },
        child: Container(
          height: 55,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: btnColor, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
