import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapa_desa/pages/masyarakat/dashboard/dashboard.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/button_form.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController judul = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController isi = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File _image;

  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/img_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/img_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  String valKategori;
  final List listKategori = [
    "Ekonomi",
    "Sosial",
    "Budaya",
    "Pendidikan",
    "Bencana Alam",
    "Pariwisata",
    "Keamanan",
    "Keagamaan",
    "Fasilitas Umum",
  ];

  Future addLaporan(File imageFile) async {
    // ignore: deprecated_member_use
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://sapadesa.nasihosting.com/addLaporan.php");
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile('img', stream, length,
        filename: basename(imageFile.path));

    request.fields['judul'] = judul.text;
    request.fields['kategori'] = valKategori;
    request.fields['lokasi'] = lokasi.text;
    request.files.add(multipartFile);
    request.fields['isi'] = isi.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      return Fluttertoast.showToast(
        msg: 'Laporan Berhasil Dikirim',
        textColor: Colors.white,
        backgroundColor: kPrimaryColor,
      );
    } else {
      return Fluttertoast.showToast(
        msg: 'Laporan Gagal Dikirim',
        textColor: Colors.white,
        backgroundColor: kPrimaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButtonFormField(
                  validator: (value) => value == null ? 'Pilih Kategori' : null,
                  hint: Text("Kategori Laporan"),
                  value: valKategori,
                  items: listKategori.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valKategori = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Judul Laporan';
                  }
                  return null;
                },
                controller: judul,
                decoration: InputDecoration(
                  labelText: 'Judul Laporan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Lokasi Kejadian';
                  }
                  return null;
                },
                controller: lokasi,
                decoration: InputDecoration(
                  labelText: 'Lokasi Kejadian',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: getImageGallery,
                    child: Icon(Icons.image),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    color: kPrimaryLightColor,
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    onPressed: getImageCamera,
                    child: Icon(Icons.camera_alt),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    color: kPrimaryLightColor,
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: _image == null
                    ? Text("Tidak ada foto yang dipilih")
                    : Image.file(_image),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Isi Laporan';
                  }
                  return null;
                },
                controller: isi,
                maxLines: 10,
                decoration: InputDecoration(
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
                  if (_formKey.currentState.validate()) {
                    if (_image == null) {
                      Fluttertoast.showToast(
                        msg: 'Harap Lampirkan Foto',
                      );
                    } else {
                      addLaporan(_image);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardMasyarakat(),
                        ),
                      );
                    }
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
