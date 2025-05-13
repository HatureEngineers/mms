import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'month_year_selector.dart';

class StudentProfilePage extends StatefulWidget {
  final String userId;
  final String userName;

  const StudentProfilePage({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  List attendanceRecords = [];
  bool isLoading = false;

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  Map<String, dynamic> attendanceMap = {};

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    setState(() => isLoading = true);

    try {
      final result = await Process.run(
        'py',
        ['C:\\zk_integration\\zk_attendance.py', 'attendance', widget.userId],
      );

      if (result.exitCode == 0) {
        final data = jsonDecode(result.stdout);
        attendanceRecords = data;

        attendanceMap = {
          for (var record in data)
            DateFormat('yyyy-MM-dd').format(DateTime.parse(record['date'])): record
        };
      } else {
        print("Script Error: ${result.stderr}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    setState(() => isLoading = false);
  }

  List<DataRow> generateTableRows() {
    List<DataRow> rows = [];
    final daysInMonth = DateUtils.getDaysInMonth(selectedYear, selectedMonth);

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(selectedYear, selectedMonth, day);
      final key = DateFormat('yyyy-MM-dd').format(date);
      final record = attendanceMap[key];

      final checkIn = record != null ? formatTime(record['check_in']) : '-';
      final checkOut = record != null ? formatTime(record['check_out']) : '-';
      final icon = record != null
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.cancel, color: Colors.red);

      rows.add(DataRow(cells: [
        DataCell(Center(child: Text(DateFormat('dd-MM-yyyy').format(date), textAlign: TextAlign.center))),
        DataCell(Center(child: Text(checkIn, textAlign: TextAlign.center))),
        DataCell(Center(child: Text(checkOut, textAlign: TextAlign.center))),
        DataCell(Center(child: icon)),
      ]));
    }

    return rows;
  }

  String formatTime(String? dateTimeStr) {
    if (dateTimeStr == null) return '';
    final dateTime = DateTime.tryParse(dateTimeStr);
    if (dateTime == null) return '';
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "ID: ${widget.userId}\nName: ${widget.userName}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            MonthYearSelector(
              selectedMonth: selectedMonth,
              selectedYear: selectedYear,
              onChanged: (month, year) {
                setState(() {
                  selectedMonth = month;
                  selectedYear = year;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth, // 👉 স্ক্রিনের প্রস্থ অনুযায়ী টেবিল
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: constraints.maxWidth * 0.05, // 👈 প্রতিটি কলামের মাঝখানের দূরত্ব স্ক্রিন অনুসারে
                          headingRowColor: WidgetStateProperty.all(Colors.blue.shade50),
                          dataRowColor: WidgetStateProperty.all(Colors.white),
                          dividerThickness: 1,
                          headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          border: TableBorder.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          columns: const [
                            DataColumn(label: Center(child: Text("Date"))),
                            DataColumn(label: Center(child: Text("Check In"))),
                            DataColumn(label: Center(child: Text("Check Out"))),
                            DataColumn(label: Center(child: Text("Attendance"))),
                          ],
                          rows: generateTableRows(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
