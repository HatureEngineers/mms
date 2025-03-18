import 'package:fl_chart/fl_chart.dart'; // ফ্ল_chart প্যাকেজ ইমপোর্ট
import 'package:flutter/material.dart';

class AttendancePieChart extends StatelessWidget {
  const AttendancePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        double textSize = screenWidth * 0.04; // স্ক্রিন অনুযায়ী ফন্ট সাইজ
        double pieChartRadius = screenWidth * 0.20; // স্ক্রিন অনুযায়ী চার্ট সাইজ

        return Card(
          elevation: 8, // শ্যাডো
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // রাউন্ডেড কোণ
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // ডায়নামিক প্যাডিং
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'উপস্থিতির অনুপাত',
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // ডায়নামিক স্পেসিং
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // চার্টের অংশ
                      Flexible(
                        flex: 3, // চার্ট বড় স্ক্রিনে বেশি জায়গা নেবে
                        child: PieChart(
                          PieChartData(
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 3,
                            centerSpaceRadius: pieChartRadius * 0.5, // রেস্পন্সিভ সেন্টার স্পেস
                            sections: [
                              PieChartSectionData(
                                value: 60,
                                color: Colors.blueAccent,
                                radius: pieChartRadius * 0.6,
                                title: '60%',
                                titleStyle: TextStyle(
                                  fontSize: textSize * 0.8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                value: 30,
                                color: Colors.redAccent,
                                radius: pieChartRadius * 0.6,
                                title: '30%',
                                titleStyle: TextStyle(
                                  fontSize: textSize * 0.8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05), // চার্টের পাশে স্পেস
                      // ইনফরমেশন লেবেল
                      Flexible(
                        flex: 2, // ছোট স্ক্রিনে টেক্সট কম জায়গা নেবে
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorInfo(
                              label: "উপস্থিত",
                              color: Colors.blueAccent,
                              percentage: "60%",
                              textSize: textSize * 0.9, // রেস্পন্সিভ ফন্ট সাইজ
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            ColorInfo(
                              label: "অনুপস্থিত",
                              color: Colors.redAccent,
                              percentage: "30%",
                              textSize: textSize * 0.9, // রেস্পন্সিভ ফন্ট সাইজ
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorInfo extends StatelessWidget {
  final String label;
  final Color color;
  final String percentage;
  final double textSize;

  const ColorInfo({
    super.key,
    required this.label,
    required this.color,
    required this.percentage,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: textSize * 1.2, // রেস্পন্সিভ ছোট বক্স
          height: textSize * 1.2,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: textSize * 0.5),
        Text(
          '$label - $percentage',
          style: TextStyle(fontSize: textSize),
        ),
      ],
    );
  }
}
