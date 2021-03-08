import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/pages/petugas/login/components/background.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapa_desa/widgets/text_field_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sapa_desa/main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  Future login() async {
    final response = await http.post(
        "http://192.168.0.103/api_sapa_desa/loginPetugas.php",
        body: {"email": email.text, "password": password.text});

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      Fluttertoast.showToast(
        msg: "Email atau Password Salah",
        fontSize: 16.0,
      );
    } else {
      if (datauser[0]['level'] == 'Admin') {
        Fluttertoast.showToast(
          msg: "Login Berhasil",
          fontSize: 16.0,
        );

        Navigator.pushReplacementNamed(context, '/AdminPage');
        setState(() {
          nama = datauser[0]['nama'];
          mail = datauser[0]['email'];
        });
      } else if (datauser[0]['level'] == 'Petugas') {
        Fluttertoast.showToast(
          msg: "Login Berhasil",
          fontSize: 16.0,
        );

        Navigator.pushReplacementNamed(context, '/PetugasPage');
        setState(() {
          nama = datauser[0]['nama'];
          mail = datauser[0]['email'];
        });
      }
    }
  }

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
            TextFieldContainer(
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email_outlined,
                    color: kPrimaryColor,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                controller: password,
                obscureText: _isHidePassword,
                onChanged: (value) {},
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePassword();
                    },
                    child: Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? Colors.grey : Colors.purple,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                if (email.text.isEmpty) {
                  return Fluttertoast.showToast(
                    msg: "Masukkan Email",
                    fontSize: 16,
                  );
                } else if (password.text.isEmpty) {
                  return Fluttertoast.showToast(
                    msg: "Masukkan Password",
                    fontSize: 16,
                  );
                } else {
                  login();
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
