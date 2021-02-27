import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sapa_desa/pages/masyarakat/laporan/create/create_laporan.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/detail/detail_laporan.dart';
import 'package:sapa_desa/pages/masyarakat/profile/profile_screen.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/main.dart';
import 'package:sapa_desa/widgets/drawer_item.dart';

class DashboardMasyarakat extends StatefulWidget {
  final String nama;
  DashboardMasyarakat({this.nama});

  @override
  _DashboardMasyarakatState createState() => _DashboardMasyarakatState();
}

class _DashboardMasyarakatState extends State<DashboardMasyarakat> {
  Future<List> getLaporan() async {
    final response =
        await http.get("http://192.168.0.103/api_sapa_desa/getLaporan.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Daftar Laporan',
        ),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List>(
        future: getLaporan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListLaporan(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListLaporan extends StatelessWidget {
  final List list;
  ListLaporan({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                width: 400,
                height: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: kPrimaryLightColor,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailLaporan(
                                list: list,
                                index: i,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            size: 50,
                            color: Colors.black,
                          ),
                          title: Text(
                            list[i]['judul'],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            list[i]['lokasi'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image(
                  image: AssetImage('assets/images/people.png'),
                  fit: BoxFit.cover),
            ),
            accountName: Text('Belajar Flutter'),
            accountEmail: Text('3200123456789'),
          ),
          DrawerItem(
            icon: Icons.add,
            text: 'Buat Laporan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateLaporan(),
                ),
              );
            },
          ),
          DrawerItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(nama: nama),
                ),
              );
            },
          ),
          DrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/MyApp');
            },
          ),
        ],
      ),
    );
  }
}
