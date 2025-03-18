import 'package:flutter/material.dart';
import 'dashboard items/charts/attendance_pie_chart.dart';
import 'dashboard items/charts/fees_pie_chart.dart';
import 'dashboard items/cards/guardians_card.dart';
import 'dashboard items/charts/student_gender_pie_chart.dart';
import 'dashboard items/cards/total_students_card.dart';
import 'dashboard items/cards/total_teachers_card.dart';

// ✅ শিক্ষক, শিক্ষার্থী এবং অভিভাবকের কার্ড Row
Row buildTopCards(bool isLargeScreen) {
  return Row(
    children: [
      Expanded(
        child: AspectRatio(
          aspectRatio: isLargeScreen ? 2.5 : 2,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: TotalTeachersCard(),
            ),
          ),
        ),
      ),
      const SizedBox(width: 16.0),
      Expanded(
        child: AspectRatio(
          aspectRatio: isLargeScreen ? 2.5 : 2,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: TotalStudentsCard(),
            ),
          ),
        ),
      ),
      const SizedBox(width: 16.0),
      Expanded(
        child: AspectRatio(
          aspectRatio: isLargeScreen ? 2.5 : 2,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: GuardiansCard(),
            ),
          ),
        ),
      ),
    ],
  );
}

// ✅ ড্যাশবোর্ডের গ্রিড ভিউ
GridView buildDashboardGrid(bool isLargeScreen) {
  final List<DashboardItem> dashboardItems = [
    DashboardItem(widget: const StudentGenderPieChart()),
    DashboardItem(widget: const FeesPieChart()),
    DashboardItem(widget: const AttendancePieChart()),
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: isLargeScreen ? 3 : 1,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: isLargeScreen ? 1.5 : 1.2,
    ),
    itemCount: dashboardItems.length,
    itemBuilder: (context, index) {
      final item = dashboardItems[index];
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: item.widget,
        ),
      );
    },
  );
}

// ✅ ড্যাশবোর্ড আইটেম ক্লাস
class DashboardItem {
  final Widget widget;

  DashboardItem({required this.widget});
}
