import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sapa_desa/pages/masyarakat/dashboard/components/header.dart';
import 'package:sapa_desa/widgets/card_laporan.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future getLaporan() async {
    final response =
        await http.get("http://192.168.0.103/api_sapa_desa/getLaporan.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          CardLaporan(
            icon: Icons.local_hospital,
            title: 'Penumpukan Pasien Puskesmas',
            subtitle: 'Bojong',
          ),
          CardLaporan(
            icon: Icons.money,
            title: 'Bansos Belum Dibagikan',
            subtitle: 'Blok Z',
          ),
          CardLaporan(
            icon: Icons.car_repair,
            title: 'Jalan Rusak',
            subtitle: 'Blok Y',
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
