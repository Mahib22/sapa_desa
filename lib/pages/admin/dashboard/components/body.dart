import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/admin/dashboard/components/header.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/detail/detail_laporan.dart';
import 'package:sapa_desa/theme.dart';
// import 'package:sapa_desa/widgets/card_laporan.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: 400,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: kPrimaryLightColor,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailLaporan(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.medical_services,
                        size: 50,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Penumpukan Pasien Puskesmas',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Bojong',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text(
                            'Cetak',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
