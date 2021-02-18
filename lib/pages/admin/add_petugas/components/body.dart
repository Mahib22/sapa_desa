import 'package:flutter/material.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:sapa_desa/widgets/rounded_input_field.dart';
import 'package:sapa_desa/widgets/rounded_password_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            RoundedInputField(
              hintText: "Nama Lengkap",
              onChanged: (value) {},
              icon: Icons.person,
            ),
            RoundedInputField(
              keyboardType: TextInputType.emailAddress,
              hintText: "E-Mail",
              onChanged: (value) {},
              icon: Icons.email,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Tambah",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
