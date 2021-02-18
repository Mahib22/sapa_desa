import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/admin/add_petugas/add_petugas.dart';
import 'package:sapa_desa/pages/admin/dashboard/components/body.dart';

class DashboardAdmin extends StatelessWidget {
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
      leading: IconButton(
        icon: Icon(
          Icons.menu_sharp,
          size: 30,
        ),
        onPressed: () {},
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPetugas(),
              ),
            );
          },
        ),
      ],
    );
  }
}
