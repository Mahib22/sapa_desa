import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/create/components/body.dart';

class CreateLaporan extends StatelessWidget {
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
      title: Text('Buat Laporan'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
