import 'package:flutter/material.dart';
import 'package:test1/W5-S2-List-Inputs/1%20-%20START%20CODE/EXERCISE-2/model/profile_tile_model.dart';
 
ProfileData ronanProfile = ProfileData(
    name: "Ronan",
    position: "Flutter Developer",
    avatarUrl: 'assets/w5-s2/aang.png',
    tiles: [
      TileData( icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
      TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
    ]);
