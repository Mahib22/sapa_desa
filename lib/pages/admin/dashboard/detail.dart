import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/admin/dashboard/viewPdf.dart';
import 'package:sapa_desa/theme.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
              <String>["Judul", "Kategori", "Lokasi", "img", "Isi"],
              ...dataLaporan.map(
                (item) => [
                  item["judul"],
                  item["kategori"],
                  item["lokasi"],
                  item["img"],
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
                  child: Image.network(
                      'http://192.168.0.103/api_sapa_desa/uploads/' +
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
    );
  }
}
