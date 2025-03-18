import 'package:flutter/material.dart';
import 'drawer_items.dart';  // ড্রয়ার আইটেম ফাইল
import 'user_profile.dart';  // ইউজারের প্রোফাইল ফাইল

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          // ইউজারের প্রোফাইল সেকশন
          UserProfile(),
          Divider(),
          // ড্রয়ারের আইটেম সেকশন
          Expanded(child: DrawerItems()),
        ],
      ),
    );
  }
}
