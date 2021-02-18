import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/admin/dashboard/dashboard.dart';
import 'package:sapa_desa/pages/petugas/login/components/background.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:sapa_desa/widgets/rounded_input_field.dart';
import 'package:sapa_desa/widgets/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              keyboardType: TextInputType.emailAddress,
              hintText: "E-Mail",
              onChanged: (value) {},
              icon: Icons.mail_outline,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardAdmin(),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
