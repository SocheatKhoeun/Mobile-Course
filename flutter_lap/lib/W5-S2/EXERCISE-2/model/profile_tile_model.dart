import 'package:flutter/material.dart';
 
const Color mainColor = Color(0xff5E9FCD);

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  const ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(icon, color: mainColor),
          title: Text(title),
          subtitle: Text(data),
        ),
      ),
    );
  }
}
