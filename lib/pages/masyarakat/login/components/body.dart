import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapa_desa/main.dart';

import 'package:sapa_desa/pages/masyarakat/login/components/background.dart';
import 'package:sapa_desa/pages/masyarakat/signup/signup_screen.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/already_have_an_account_acheck.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapa_desa/widgets/text_field_container.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController telp = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  Future login() async {
    final response = await http.post(
        "https://sapadesa.nasihosting.com/loginMasyarakat.php",
        body: {"telp": telp.text, "password": password.text});

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      Fluttertoast.showToast(
        msg: "No. HP atau Password Salah",
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Login Berhasil",
        fontSize: 16.0,
      );

      Navigator.pushReplacementNamed(context, '/MasyarakatPage');

      setState(() {
        nama = datauser[0]['nama'];
        nik = datauser[0]['nik'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
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
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: TextFormField(
                  controller: telp,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                      color: kPrimaryColor,
                    ),
                    hintText: "No. HP",
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
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                  if (telp.text.isEmpty) {
                    return Fluttertoast.showToast(
                      msg: "Masukkan No. HP",
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
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
