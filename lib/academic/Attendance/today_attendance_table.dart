import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayAttendanceTable extends StatefulWidget {
  final String searchText;

  const TodayAttendanceTable({super.key, required this.searchText});

  @override
  _TodayAttendanceTableState createState() => _TodayAttendanceTableState();
}

class _TodayAttendanceTableState extends State<TodayAttendanceTable> {
  List attendanceRecords = [];
  List users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      // Load attendance data
      final attendanceResult = await Process.run(
        'C:\\Python313\\python.exe',
        ['C:\\zk_integration\\zk_attendance.py'],
      );

      // Load user data
      final userResult = await Process.run(
        'C:\\Python313\\python.exe',
        ['C:\\zk_integration\\zk_attendance.py', 'users'],
      );

      if (attendanceResult.exitCode == 0 && userResult.exitCode == 0) {
        final attendanceData = jsonDecode(attendanceResult.stdout);
        final userData = jsonDecode(userResult.stdout);

        // Map user_id to name
        final Map userMap = {
          for (var u in userData) u['user_id'].toString(): u['name']
        };

        // Merge name into attendance records
        for (var record in attendanceData) {
          final uid = record['user_id'].toString();
          record['name'] = userMap[uid] ?? 'N/A';
        }

        setState(() {
          attendanceRecords = attendanceData;
          isLoading = false;
        });
      } else {
        print("Error: ${attendanceResult.stderr}\n${userResult.stderr}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Exception: $e");
      setState(() => isLoading = false);
    }
  }

  String formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return 'N/A';
    final dt = DateTime.tryParse(dateTimeStr);
    if (dt == null) return 'N/A';
    return DateFormat('dd-MM-yyyy hh:mm a').format(dt);
  }

  Widget borderedCell(Widget child, {Alignment alignment = Alignment.centerLeft}) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = attendanceRecords.where((record) {
      final id = record['user_id'].toString();
      return id.contains(widget.searchText);
    }).toList();

    filtered.sort((a, b) {
      final aTime = DateTime.tryParse(a['check_in'] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = DateTime.tryParse(b['check_in'] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime); // Descending order
    });

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filtered.isEmpty) {
      return const Center(child: Text("আজকের কোনো তথ্য পাওয়া যায়নি"));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                  columnSpacing: 24,
                  dataRowMinHeight: 56,
                  dataRowMaxHeight: 56,
                  columns: const [
                    DataColumn(label: Text("No.", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Attendance", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Check In", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Check Out", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filtered.asMap().entries.map((entry) {
                    final index = entry.key;
                    final record = entry.value;
                    final checkIn = record['check_in'];
                    final checkOut = record['check_out'];
                    final hasCheckIn = checkIn != null && checkIn.toString().isNotEmpty;

                    return DataRow(
                      cells: [
                        DataCell(borderedCell(Text((index + 1).toString()))),
                        DataCell(borderedCell(Text(record['name'] ?? 'N/A'))),
                        DataCell(borderedCell(Text(record['user_id'].toString()))),
                        DataCell(
                          borderedCell(
                            Center(
                              child: Icon(
                                hasCheckIn ? Icons.check_circle : Icons.cancel,
                                color: hasCheckIn ? Colors.green : Colors.red,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        DataCell(
                          borderedCell(
                            Text(
                              formatDateTime(checkIn),
                              style: TextStyle(color: hasCheckIn ? Colors.black : Colors.red),
                            ),
                          ),
                        ),
                        DataCell(
                          borderedCell(
                            Text(
                              formatDateTime(checkOut),
                              style: TextStyle(
                                color: checkOut != null && checkOut.toString().isNotEmpty ? Colors.black : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
