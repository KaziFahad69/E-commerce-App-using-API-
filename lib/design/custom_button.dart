
import 'package:day53/design/custom_textstyle.dart';
import 'package:flutter/material.dart';


Widget CustomButton (String buttonText, onTap){
  return SizedBox(
    width: 1,
    height: 56,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        child: Center(
            child: Text(
              buttonText,
              style: myStyle(
                  20,
                  Colors.white,
                  FontWeight.w700),
            )),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff5660CD),
            Color(0xff7B81EC),
          ]),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
}