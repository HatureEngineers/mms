import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StudentGenderPieChart extends StatelessWidget {
  const StudentGenderPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        double textSize = screenWidth * 0.04; // স্ক্রিন অনুযায়ী ফন্ট সাইজ
        double pieChartRadius = screenWidth * 0.20; // স্ক্রিন অনুযায়ী চার্ট সাইজ

        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // ডায়নামিক প্যাডিং
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'শিক্ষার্থীর অনুপাত',
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // ডায়নামিক স্পেসিং
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 3,
                      centerSpaceRadius: pieChartRadius * 0.5, // রেস্পন্সিভ সেন্টার স্পেস
                      sections: [
                        PieChartSectionData(
                          value: 60,
                          color: Colors.blue,
                          title: 'ছাত্র',
                          radius: pieChartRadius * 0.6, // চার্ট রেস্পন্সিভ
                          titleStyle: TextStyle(
                            fontSize: textSize * 0.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 40,
                          color: Colors.pink[300]!,
                          title: 'ছাত্রী',
                          radius: pieChartRadius * 0.6, // চার্ট রেস্পন্সিভ
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
              ],
            ),
          ),
        );
      },
    );
  }
}
