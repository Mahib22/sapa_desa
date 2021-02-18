import 'package:flutter/material.dart';
import 'package:sapa_desa/main.dart';
import 'package:sapa_desa/widgets/biodata_tile.dart';
import 'package:sapa_desa/theme.dart';
import 'package:shape_of_view/shape_of_view.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(
            height: height,
          ),
          ShapeOfView(
            shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 45,
              position: ArcPosition.Bottom,
            ),
            child: Container(
              height: height * 0.20,
              color: kPrimaryColor,
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: height * 0.2,
                width: width * 0.3,
                child: CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  backgroundImage: AssetImage('assets/images/people.png'),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.3,
              ),
              Center(
                child: Text(
                  '$nama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.35,
              ),
              Center(
                child: Text(
                  '3200123456789',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 270),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BiodataTile(
                        icon: Icons.phone_android,
                        title: 'No. Hp',
                        subtitle: '08123456789',
                      ),
                      BiodataTile(
                        icon: Icons.cake,
                        title: 'Tanggal Lahir',
                        subtitle: '30 Februari 2000',
                      ),
                      BiodataTile(
                        icon: Icons.location_on,
                        title: 'Alamat',
                        subtitle:
                            'Kec. Gunungputri, Kab. Bogor, Jawa Barat, 16055',
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
