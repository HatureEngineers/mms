import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FeesPieChart extends StatelessWidget {
  const FeesPieChart({super.key});

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
                  'বেতনের অনুপাত',
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // ডায়নামিক স্পেসিং
                Expanded(
                  child: Row(
                    children: [
                      // চার্ট
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: pieChartRadius * 0.5,
                            sections: [
                              PieChartSectionData(
                                value: 70,
                                color: Colors.green,
                                radius: pieChartRadius * 0.6, // রেস্পন্সিভ রেডিয়াস
                              ),
                              PieChartSectionData(
                                value: 30,
                                color: Colors.red,
                                radius: pieChartRadius * 0.6, // রেস্পন্সিভ রেডিয়াস
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // কালার লেবেল
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ColorInfo(
                            label: "পরিশোধিত",
                            color: Colors.green,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          const ColorInfo(
                            label: "বকেয়া",
                            color: Colors.redAccent,
                          ),
                        ],
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

// কালার লেবেল উইজেট
class ColorInfo extends StatelessWidget {
  final String label;
  final Color color;

  const ColorInfo({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
