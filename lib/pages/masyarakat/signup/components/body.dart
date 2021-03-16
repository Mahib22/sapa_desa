import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sapa_desa/pages/masyarakat/Login/login_screen.dart';
import 'package:sapa_desa/pages/masyarakat/Signup/components/background.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/already_have_an_account_acheck.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:sapa_desa/widgets/text_field_container.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String nik, nama, telp, password;
  final _key = new GlobalKey<FormState>();

  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http.post(
        "https://sapadesa.nasihosting.com/register.php",
        body: {"nik": nik, "nama": nama, "telp": telp, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      showDialog(
        context: context,
        builder: (_) => FlareGiffyDialog(
          flarePath: 'assets/images/space_demo.flr',
          flareAnimation: 'loading',
          title: Text(
            pesan,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          description: Text(
            'Silahkan login dengan akun yang sudah dibuat.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          entryAnimation: EntryAnimation.DEFAULT,
          onOkButtonPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: pesan,
        fontSize: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Buat Akun",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukkan NIK";
                    }
                  },
                  onSaved: (e) => nik = e,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin_rounded,
                      color: kPrimaryColor,
                    ),
                    hintText: "NIK",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukkan Nama Lengkap";
                    }
                  },
                  onSaved: (e) => nama = e,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Nama Lengkap",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukkan No. HP";
                    }
                  },
                  onSaved: (e) => telp = e,
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
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukkan Password";
                    }
                  },
                  onSaved: (e) => password = e,
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
                text: "DAFTAR",
                press: () {
                  check();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
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
            ],
          ),
        ),
      ),
    );
  }
}
