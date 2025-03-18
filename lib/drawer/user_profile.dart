import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: isLargeScreen ? 70 : 50, // বড় স্ক্রীনে বড়, ছোট স্ক্রীনে ছোট
            backgroundColor: Colors.blue[100], // ব্যাকগ্রাউন্ড রঙ
            backgroundImage: AssetImage('assets/ic_launcher.png'), // অ্যাসেট ইমেজ

            onBackgroundImageError: (error, stackTrace) {
              debugPrint("Image load failed: $error"); // যদি ইমেজ লোড না হয়, লগ দেখাবে
            },

            child: Image.asset(
              'assets/ic_launcher.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.person, // যদি ইমেজ লোড না হয়, Person আইকন দেখাবে
                  size: isLargeScreen ? 70 : 50, // স্ক্রিন অনুযায়ী আইকনের আকার
                  color: Colors.grey[700],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'HIISC',
            style: TextStyle(
              fontSize: isLargeScreen ? 30 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 8),
          // Text(
          //   'ফোন: 01*********', // ইউজারের ইমেইল এখানে
          //   style: TextStyle(
          //     fontSize: isLargeScreen ? 20 : 16,
          //   ),
          // ),
          // const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     // ইউজার তথ্য আপডেট করার ফাংশন
          //   },
          //   child: const Text('Edit Profile'),
          // ),
        ],
      ),
    );
  }
}
