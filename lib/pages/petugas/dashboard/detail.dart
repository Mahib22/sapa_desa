import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/theme.dart';
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
  TextEditingController ctanggapan = TextEditingController();

  void addTanggapan() {
    var url = "https://sapadesa.nasihosting.com/tanggapan.php";

    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "tanggapan": ctanggapan.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
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
                      child: Image.network(
                          'https://sapadesa.nasihosting.com/uploads/' +
                              '${widget.list[widget.index]['img']}'),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.black87,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Tanggapan : ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: widget.list[widget.index]['tanggapan'] == null
                          ? Text('Laporan belum ditanggapi',
                              style: TextStyle(
                                fontSize: 14,
                              ))
                          : Text(
                              '${widget.list[widget.index]['tanggapan']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              widget.list[widget.index]['tanggapan'] == null
                  ? Column(
                      children: [
                        SizedBox(height: 30),
                        TextFormField(
                          controller: ctanggapan,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Tanggapan',
                            hintText: 'Tulis Tanggapan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          onPressed: () {
                            if (ctanggapan.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Tanggapan Harus Diisi',
                              );
                            } else {
                              addTanggapan();
                              Fluttertoast.showToast(
                                msg: 'Tanggapan Berhasil Dikirim',
                              );
                              Navigator.pop(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          child: Text(
                            'Kirim',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: kPrimaryColor,
                        ),
                      ],
                    )
                  : SizedBox(height: 10),
            ],
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
    );
  }
}
