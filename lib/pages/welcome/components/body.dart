import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/masyarakat/Login/login_screen.dart';
import 'package:sapa_desa/pages/Welcome/components/background.dart';
import 'package:sapa_desa/pages/petugas/login/login_petugas.dart';
import 'package:sapa_desa/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SAPA DESA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "MASYARAKAT",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "PETUGAS",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPetugas();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
