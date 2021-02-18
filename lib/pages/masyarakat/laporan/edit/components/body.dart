import 'package:flutter/material.dart';
import 'package:sapa_desa/widgets/button_form.dart';
import 'package:sapa_desa/widgets/form_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              InputFormField(
                maxLines: 1,
                hintText: 'Judul Laporan Anda',
                labelText: 'Judul',
              ),
              InputFormField(
                maxLines: 1,
                hintText: 'Kategori Laporan Anda',
                labelText: 'Kategori',
              ),
              InputFormField(
                maxLines: 1,
                hintText: 'Tanggal Kejadian',
                labelText: 'Tanggal',
              ),
              InputFormField(
                maxLines: 1,
                hintText: 'Lokasi Kejadian',
                labelText: 'Lokasi',
              ),
              InputFormField(
                maxLines: 10,
                hintText: 'Isi Laporan Anda',
                labelText: 'Isi Laporan',
              ),
              ButtonForm(
                title: 'Kirim',
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
