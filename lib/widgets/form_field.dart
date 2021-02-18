import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final num maxLines;
  final String hintText;
  final String labelText;

  InputFormField({
    this.hintText,
    this.labelText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
