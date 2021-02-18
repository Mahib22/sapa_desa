import 'package:flutter/material.dart';

class BiodataTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  BiodataTile({
    this.icon,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 100,
        child: Icon(
          icon,
        ),
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
      ),
    );
  }
}
