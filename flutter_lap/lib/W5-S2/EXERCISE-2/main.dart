import 'package:flutter/material.dart';
import 'data/profile_data.dart';
import 'model/profile_tile_model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileApp(
      profile: ProfileData(
        name: "Ronan OGOR",
        position: "Flutter Developer",
        avatarUrl: 'assets/w4-s2/man.jpg',
        tiles: [
          TileData(icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
          TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
          TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
          TileData(icon: Icons.link, title: "LinkedIn", value: "linkedin.com/in/ronanogor"),
        ],
      ),
    ),
  ));
}

const Color mainColor = Color(0xff5E9FCD);

class ProfileApp extends StatelessWidget {
  final ProfileData profile;

  const ProfileApp({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor.withAlpha(100),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'CADT Student Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profile.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            Text(
              profile.position,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            // Use a ListView builder to display tiles dynamically and manage scrolling
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.tiles.length,
              itemBuilder: (context, index) {
                final tile = profile.tiles[index];
                return ProfileTile(
                  icon: tile.icon,
                  title: tile.title,
                  data: tile.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
