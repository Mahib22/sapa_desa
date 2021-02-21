import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/pages/masyarakat/dashboard/dashboard.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/button_form.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController judul = TextEditingController();
  TextEditingController kategori = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController isi = TextEditingController();

  void addLaporan() {
    var url = "http://192.168.0.103/api_sapa_desa/addLaporan.php";

    http.post(url, body: {
      "judul": judul.text,
      "kategori": kategori.text,
      "lokasi": lokasi.text,
      "img": img.text,
      "isi": isi.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                title: 'Kirim',
                press: () {
                  if (judul.text.isEmpty) {
                    return Fluttertoast.showToast(msg: 'Judul harus diisi');
                  } else if (kategori.text.isEmpty) {
                    return Fluttertoast.showToast(msg: 'Kategori harus diisi');
                  } else if (lokasi.text.isEmpty) {
                    return Fluttertoast.showToast(msg: 'Lokasi harus diisi');
                  } else if (img.text.isEmpty) {
                    return Fluttertoast.showToast(msg: 'Img harus diisi');
                  } else if (isi.text.isEmpty) {
                    return Fluttertoast.showToast(
                        msg: 'Isi Laporan masih kosong');
                  } else {
                    addLaporan();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardMasyarakat(),
                      ),
                    );
                    return Fluttertoast.showToast(
                      msg: 'Laporan Berhasil Dibuat',
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
    );
  }
}
