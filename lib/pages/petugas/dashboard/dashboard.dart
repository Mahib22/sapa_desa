import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/petugas/dashboard/detail.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/drawer_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DashboardPetugas extends StatefulWidget {
  @override
  _DashboardPetugasState createState() => _DashboardPetugasState();
}

class _DashboardPetugasState extends State<DashboardPetugas> {
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
          'Laporan Masuk',
        ),
      ),
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
      drawer: MyDrawer(),
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
            accountEmail: Text('test@gmail.com'),
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
