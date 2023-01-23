import 'package:flutter/material.dart';

import 'app_styles.dart';

InputDecoration buildInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(22.0, 20.0, 22.0, 20.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
  );
}

Padding longButtons(String title, VoidCallback fun,
    {Color color: kPrimaryColor, Color textColor: Colors.white}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, right: 0.0),
    child: MaterialButton(
        onPressed: fun,
        textColor: textColor,
        color: color,
        height: 50,
        minWidth: 600,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),

        child: SizedBox(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: kBodyText1.copyWith(color: Colors.white, fontSize: 14),
          ),
        )
    ),
  ); }

