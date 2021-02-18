import 'package:flutter/material.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/detail/detail_laporan.dart';
import 'package:sapa_desa/pages/masyarakat/laporan/edit/edit_laporan.dart';
import 'package:sapa_desa/theme.dart';

class CardLaporan extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  CardLaporan({
    this.icon,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  icon,
                  size: 50,
                  color: Colors.black,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle,
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
                      'Edit',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditLaporan(),
                        ),
                      );
                    },
                  ),
                  FlatButton(
                    child: const Text(
                      'Hapus',
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
    );
  }
}
