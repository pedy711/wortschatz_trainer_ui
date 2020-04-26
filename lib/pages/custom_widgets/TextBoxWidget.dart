import 'package:flutter/material.dart';

class TextFieldWidget extends TextField {
  TextFieldWidget(
      {Key key,
      @required this.text,
      @required this.controller,
      @required this.textStyle,
      @required this.onChanged,
      this.keyboardType,
      // this.obscureText
      })
      : super(
            key: key,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            // obscureText: obscureText ?? false,
            decoration: InputDecoration(
                labelText: text,
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))));

  final String text;
  final TextStyle textStyle;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  // final bool obscureText;

/*   @override
  Widget build(BuildContext context) {
    return TextField();
  } */
}
