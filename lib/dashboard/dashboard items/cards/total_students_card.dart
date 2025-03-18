import 'package:flutter/material.dart';

class TotalStudentsCard extends StatelessWidget {
  const TotalStudentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // স্ক্রিন সাইজের ডেটা
    final Size screenSize = MediaQuery.of(context).size;

    // স্ক্রিনের প্রস্থ অনুযায়ী সাইজ অ্যাডজাস্ট
    final double iconSize = screenSize.width * 0.035; // আইকনের সাইজ
    final double fontSizeTitle = screenSize.width * 0.012; // শিরোনামের ফন্ট সাইজ
    final double fontSizeCount = screenSize.width * 0.016; // সংখ্যার ফন্ট সাইজ

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: iconSize,
              color: Colors.blue,
            ),
            Text(
              'মোট শিক্ষার্থী',
              style: TextStyle(
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '120', // Replace with dynamic count
              style: TextStyle(
                fontSize: fontSizeCount,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
