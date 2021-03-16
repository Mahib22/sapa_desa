import 'package:flutter/material.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/rounded_button.dart';
import 'package:sapa_desa/widgets/text_field_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isHidePassword = true;
  final _formKey = GlobalKey<FormState>();

  String valLevel;
  final List listLevel = ["Petugas", "Admin"];

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  Future register() async {
    var url = "https://sapadesa.nasihosting.com/addPetugas.php";

    var response = await http.post(url, body: {
      "nama": nama.text,
      "email": email.text,
      "level": valLevel,
      "password": password.text,
    });

    var data = json.decode(response.body);
    if (data == "Error") {
      final snackBar = SnackBar(
        content: Text('User Telah Terdaftar'),
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('User Berhasil Di Daftarkan'),
        duration: Duration(seconds: 5),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(35),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Masukkan Nama';
                      }
                      return null;
                    },
                    controller: nama,
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Nama Lengkap",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              TextFieldContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Masukkan Email';
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "E-Mail",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              TextFieldContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonFormField(
                    validator: (value) => value == null ? 'Pilih Level' : null,
                    hint: Text("Level"),
                    value: valLevel,
                    items: listLevel.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valLevel = value;
                      });
                    },
                  ),
                ),
              ),
              TextFieldContainer(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Masukkan Password';
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: _isHidePassword,
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
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
              ),
              RoundedButton(
                text: "Tambah",
                press: () {
                  if (_formKey.currentState.validate()) {
                    register();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
