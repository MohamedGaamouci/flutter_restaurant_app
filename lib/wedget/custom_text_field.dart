import 'package:flutter/material.dart';

class Custom_text_field extends StatelessWidget {
  TextEditingController? controller;
  IconData? iconData;
  String? hintText;
  bool isObsecure = false;
  bool? enable = false;
  String? labelText;
  TextInputType? fieldType;

  dynamic inputText;
  // isObsecure_methos(isObsecure) {
  //     if (isObsecure == null || isObsecure == false) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   }
  Custom_text_field(
      {this.controller,
      this.iconData,
      this.hintText,
      required this.isObsecure,
      this.enable,
      this.labelText,
      this.fieldType});

  returnText() {
    return inputText.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onSaved: (newValue) {
          inputText = newValue;
        },
        keyboardType: fieldType,
        obscureText: isObsecure,
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            // ignore: prefer_const_constructors
            labelStyle: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
            prefixIcon: Icon(iconData, color: Colors.orange),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                // ignore: prefer_const_constructors
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 221, 133, 0),
                  width: 2,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                // ignore: prefer_const_constructors
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 221, 133, 0),
                  width: 2,
                ))),
      ),
    );
  }
}
