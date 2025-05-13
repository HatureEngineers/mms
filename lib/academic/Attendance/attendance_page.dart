import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'search_bar.dart';
import 'today_attendance_table.dart';
import 'user_list.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String selectedView = 'today'; // today, student, staff
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text(
              "Attendance",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ToggleButtons(
              isSelected: [
                selectedView == 'today',
                selectedView == 'student',
                selectedView == 'staff',
              ],
              onPressed: (index) {
                setState(() {
                  selectedView = ['today', 'student', 'staff'][index];
                });
              },
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Attend"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Students"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(" Staff "),
                ),
              ],
            ),
          ),
          SearchBarWidget(
            onSearch: (text) => setState(() => searchText = text),
          ),
          Expanded(
            child: selectedView == 'today'
                ? TodayAttendanceTable(searchText: searchText)
                : UserList(type: selectedView, searchText: searchText,),
          ),
        ],
      ),
    );
  }
}
