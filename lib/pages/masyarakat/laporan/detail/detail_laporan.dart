import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/pages/masyarakat/dashboard/dashboard.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/edit/edit_laporan.dart';
import 'package:sapa_desa/theme.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;

class DetailLaporan extends StatefulWidget {
  final List list;
  final int index;
  DetailLaporan({
    this.index,
    this.list,
  });

  @override
  _DetailLaporanState createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  void deleteLaporan() {
    var url = "http://192.168.0.103/api_sapa_desa/deleteLaporan.php";

    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: kPrimaryLightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    '${widget.list[widget.index]['judul']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Kategori: ${widget.list[widget.index]['kategori']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Lokasi: ${widget.list[widget.index]['lokasi']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Image.asset("assets/images/banjir.jpg"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${widget.list[widget.index]['isi']}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text('${widget.list[widget.index]['judul']}'),
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
        IconButton(
          tooltip: 'Edit',
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditLaporan(
                  list: widget.list,
                  index: widget.index,
                ),
              ),
            );
          },
        ),
        IconButton(
          tooltip: 'Hapus',
          icon: Icon(
            Icons.delete,
            size: 30,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AssetGiffyDialog(
                image: Image.asset('assets/images/gifchat.gif'),
                title: Text(
                  'Hapus Laporan',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  "Apakah Anda yakin ingin menghapus ${widget.list[widget.index]['judul']} ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                entryAnimation: EntryAnimation.TOP,
                onOkButtonPressed: () {
                  deleteLaporan();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardMasyarakat(),
                    ),
                  );
                  return Fluttertoast.showToast(
                    msg: 'Laporan Berhasil Dihapus',
                    textColor: Colors.white,
                    backgroundColor: kPrimaryColor,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
