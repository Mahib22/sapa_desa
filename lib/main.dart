import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/Welcome/welcome_screen.dart';
import 'package:sapa_desa/pages/admin/dashboard/dashboard.dart';
import 'package:sapa_desa/pages/masyarakat/dashboard/dashboard.dart';
import 'package:sapa_desa/pages/petugas/dashboard/dashboard.dart';
import 'package:sapa_desa/theme.dart';

void main() {
  runApp(MyApp());
}

String nama = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sapa Desa',
      home: WelcomeScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/MasyarakatPage': (BuildContext context) =>
            new DashboardMasyarakat(nama: nama),
        '/MyApp': (BuildContext context) => new MyApp(),
        '/AdminPage': (BuildContext context) => new DashboardAdmin(),
        '/PetugasPage': (BuildContext context) => new DashboardPetugas(),
      },
    );
  }
}
