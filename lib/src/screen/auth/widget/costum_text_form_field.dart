import 'package:flutter/material.dart';

class CostumTextFormField extends StatelessWidget {
  final Color bgColor;
  final TextStyle textStyle;
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final bool obscureText;
  final String icon;
  final double iconHeight;

  const CostumTextFormField(
      {super.key,
      required this.bgColor,
      required this.textStyle,
      required this.controller,
      required this.obscureText,
      required this.hintStyle,
      required this.hintText,
      required this.icon, required this.iconHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(icon, height: iconHeight,),
              Expanded(
                child: TextFormField(
                    obscureText: obscureText,
                    controller: controller,
                    style: textStyle,
                    decoration: InputDecoration.collapsed(
                        hintText: hintText, hintStyle: hintStyle)),
              ),
            ],
          ),
        ));
  }
}
