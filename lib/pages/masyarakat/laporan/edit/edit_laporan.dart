import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/pages/masyarakat/dashboard/dashboard.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/button_form.dart';
import 'package:http/http.dart' as http;

class EditLaporan extends StatefulWidget {
  final List list;
  final int index;

  EditLaporan({
    this.list,
    this.index,
  });

  @override
  _EditLaporanState createState() => _EditLaporanState();
}

class _EditLaporanState extends State<EditLaporan> {
  TextEditingController judul;
  TextEditingController kategori;
  TextEditingController lokasi;
  TextEditingController img;
  TextEditingController isi;

  void editLaporan() {
    var url = "http://192.168.0.103/api_sapa_desa/editLaporan.php";

    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "judul": judul.text,
      "kategori": kategori.text,
      "lokasi": lokasi.text,
      "img": img.text,
      "isi": isi.text,
    });
  }

  @override
  void initState() {
    judul = TextEditingController(text: widget.list[widget.index]['judul']);
    kategori =
        TextEditingController(text: widget.list[widget.index]['kategori']);
    lokasi = TextEditingController(text: widget.list[widget.index]['lokasi']);
    img = TextEditingController(text: widget.list[widget.index]['img']);
    isi = TextEditingController(text: widget.list[widget.index]['isi']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  controller: judul,
                  decoration: InputDecoration(
                    hintText: 'Judul Laporan Anda',
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: kategori,
                  decoration: InputDecoration(
                    hintText: 'Kategori Laporan Anda',
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lokasi,
                  decoration: InputDecoration(
                    hintText: 'Lokasi Kejadian',
                    labelText: 'Lokasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: img,
                  decoration: InputDecoration(
                    hintText: 'Foto',
                    labelText: 'Foto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: isi,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Isi Laporan Anda',
                    labelText: 'Isi Laporan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ButtonForm(
                  title: 'Edit Laporan',
                  press: () {
                    if (judul.text.isEmpty) {
                      return Fluttertoast.showToast(msg: 'Judul harus diisi');
                    } else if (kategori.text.isEmpty) {
                      return Fluttertoast.showToast(
                          msg: 'Kategori harus diisi');
                    } else if (lokasi.text.isEmpty) {
                      return Fluttertoast.showToast(msg: 'Lokasi harus diisi');
                    } else if (img.text.isEmpty) {
                      return Fluttertoast.showToast(msg: 'Img harus diisi');
                    } else if (isi.text.isEmpty) {
                      return Fluttertoast.showToast(
                          msg: 'Isi Laporan masih kosong');
                    } else {
                      editLaporan();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardMasyarakat(),
                        ),
                      );
                      return Fluttertoast.showToast(
                        msg: 'Laporan Berhasil Diedit',
                        textColor: Colors.white,
                        backgroundColor: kPrimaryColor,
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
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
      title: Text('Edit Laporan'),
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
