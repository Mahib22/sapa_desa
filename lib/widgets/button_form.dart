import 'package:flutter/material.dart';
import 'package:sapa_desa/theme.dart';

class ButtonForm extends StatelessWidget {
  final String title;
  final Function press;

  ButtonForm({
    this.title,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      color: kPrimaryColor,
      onPressed: press,
    );
  }
}
