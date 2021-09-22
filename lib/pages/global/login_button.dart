import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  String name;
  VoidCallback? onPress;
  Color? buttonColor;
  Color? textColor;
  double? textSize;
  double? borderRadius;
  double? height;

  LoginButton(
      {required this.name,
      this.onPress,
      this.buttonColor,
      this.borderRadius,
      this.height,
      this.textColor,
      this.textSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: textSize),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
    );
  }
}
