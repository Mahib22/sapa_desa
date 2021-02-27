import 'package:flutter/material.dart';
import 'package:sapa_desa/widgets/drawer_item.dart';

class DashboardPetugas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Laporan Masuk',
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image(
                  image: AssetImage('assets/images/people.png'),
                  fit: BoxFit.cover),
            ),
            accountName: Text('Belajar Flutter'),
            accountEmail: Text('test@gmail.com'),
          ),
          DrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/MyApp');
            },
          ),
        ],
      ),
    );
  }
}
