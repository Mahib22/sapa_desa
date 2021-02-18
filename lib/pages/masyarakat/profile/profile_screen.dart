import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/masyarakat/profile/components/body.dart';

class ProfilePage extends StatelessWidget {
  final String nama;
  ProfilePage({this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text('Profile'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.logout,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/MyApp');
          },
        ),
      ],
    );
  }
}
