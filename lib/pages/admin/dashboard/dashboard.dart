import 'package:flutter/material.dart';
import 'package:sapa_desa/main.dart';
import 'package:sapa_desa/pages/admin/add_petugas/add_petugas.dart';
import 'package:sapa_desa/pages/admin/dashboard/detail.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/drawer_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sapa_desa/pages/admin/dashboard/viewPdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DashboardAdmin extends StatefulWidget {
  final String nama;
  final String mail;
  DashboardAdmin({this.nama, this.mail});

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  Future<List> getLaporan() async {
    final response =
        await http.get("http://192.168.0.103/api_sapa_desa/getLaporan.php");
    return json.decode(response.body);
  }

  void exportPDF(context) async {
    var res =
        await http.get("http://192.168.0.103/api_sapa_desa/getLaporan.php");

    List dataLaporan = jsonDecode(res.body);

    final pw.Document pdf = pw.Document(deflate: zlib.encode);

    pdf.addPage(
      pw.MultiPage(
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              <String>["Judul", "Kategori", "Lokasi", "Isi"],
              ...dataLaporan.map(
                (item) => [
                  item["judul"],
                  item["kategori"],
                  item["lokasi"],
                  item["isi"],
                ],
              ),
            ],
          ),
        ],
      ),
    );

    final String dir = (await getExternalStorageDirectory()).path;
    final String path = "$dir/Laporan_Pengaduan.pdf";
    final File file = File(path);

    print(path);
    file.writeAsBytesSync(await pdf.save());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewPdf(
          path: path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Daftar Laporan',
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Print',
            icon: Icon(
              Icons.print,
              size: 30,
            ),
            onPressed: () {
              exportPDF(context);
            },
          ),
        ],
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
            // currentAccountPicture: ClipOval(
            //   child: Image(
            //       image: AssetImage('assets/images/people.png'),
            //       fit: BoxFit.cover),
            // ),
            accountName: Text(
              '$nama',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            accountEmail: Text(
              '$mail',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          DrawerItem(
            icon: Icons.add,
            text: 'Tambah Petugas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPetugas(),
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
