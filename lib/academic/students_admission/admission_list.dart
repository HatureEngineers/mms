import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'table_filter_section.dart';

class AdmissionList extends StatefulWidget {
  const AdmissionList({super.key});

  @override
  _AdmissionListState createState() => _AdmissionListState();
}

class _AdmissionListState extends State<AdmissionList> {
  String selectedFilter = 'সকল';
  final TextEditingController searchController = TextEditingController();

  final List<String> filters = ['সকল', 'দাখেলা', 'নাম', 'শিক্ষাবর্ষ', 'ক্লাস', 'ফোন'];
  final List<String> academicYears = ['সকল', '2025', '2024', '2023'];
  final List<String> classes = ['সকল', '১ম', '২য়', '৩য়', '৪র্থ', '৫ম'];

  String? selectedYear = 'সকল';
  String? selectedClass = 'সকল';

  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/students'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          students = data.map((student) => {
            'entry_no': student['entry_no'] ?? 'N/A',
            'name': student['name'] ?? 'N/A',
            'phone': student['phone'] ?? 'N/A',
            'year': student['year'] ?? 'N/A',
            'class': student['class'] ?? 'N/A',
            'father': student['father'] ?? 'N/A',
            'hostel': student['hostel'] ?? 'N/A',
            'transaction': student['transaction'] ?? 'N/A',
          }).toList();

          filteredStudents = List.from(students);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty || selectedFilter == 'সকল') {
        filteredStudents = List.from(students);
      } else {
        filteredStudents = students.where((student) {
          String searchField = student[selectedFilter == 'নাম'
              ? 'name'
              : selectedFilter == 'দাখেলা'
              ? 'id'
              : selectedFilter == 'ফোন'
              ? 'phone'
              : selectedFilter == 'শিক্ষাবর্ষ'
              ? 'year'
              : 'class'] ?? '';
          return searchField.contains(query);
        }).toList();
      }
    });
  }

  void _filterByDropdown() {
    setState(() {
      filteredStudents = students.where((student) {
        bool yearMatch = (selectedYear == 'সকল' || student['year'] == selectedYear);
        bool classMatch = (selectedClass == 'সকল' || student['class'] == selectedClass);
        return yearMatch && classMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterSection(
                title:  'ভর্তি করা শিক্ষার্থীর তালিকা',
                selectedFilter: selectedFilter,
                searchController: searchController,
                filters: filters,
                academicYears: academicYears,
                classes: classes,
                selectedYear: selectedYear,
                selectedClass: selectedClass,
                onFilterChanged: (newFilter) {
                  setState(() {
                    selectedFilter = newFilter;
                    _filterStudents('');
                  });
                },
                onYearChanged: (year) {
                  setState(() {
                    selectedYear = year;
                    _filterByDropdown();
                  });
                },
                onClassChanged: (cls) {
                  setState(() {
                    selectedClass = cls;
                    _filterByDropdown();
                  });
                },
                onSearch: (query) => _filterStudents(query),
              ),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: DataTable(
                      columnSpacing: 20.0,
                      headingRowHeight: 50.0,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      headingRowColor: WidgetStateColor.resolveWith((states) => Colors.blue),
                      border: TableBorder.all(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                      columns: const [
                        DataColumn(label: Center(child: Text('No.'))),
                        DataColumn(label: Expanded(child: Center(child: Text('দাখেলা')))),
                        DataColumn(label: Expanded(child: Center(child: Text('শিক্ষার্থীর নাম')))),
                        DataColumn(label: Expanded(child: Center(child: Text('জামাত')))),
                        DataColumn(label: Expanded(child: Center(child: Text('শিক্ষাবর্ষ')))),
                        DataColumn(label: Expanded(child: Center(child: Text('হোস্টেল')))),
                        DataColumn(label: Expanded(child: Center(child: Text('পিতা নাম')))),
                        DataColumn(label: Expanded(child: Center(child: Text('মোবাইল')))),
                        DataColumn(label: Expanded(child: Center(child: Text('লেনদেন')))),
                      ],
                      rows: filteredStudents.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        var student = entry.value;
                        return DataRow(cells: [
                          DataCell(Text('$index')),
                          DataCell(Center(child: Text(student["entry_no"] ?? 'N/A'))),
                          DataCell(Center(child: Text(student["name"] ?? 'N/A'))),
                          DataCell(Center(child: Text(student["class"] ?? 'N/A'))),
                          DataCell(Center(child: Text(student["year"] ?? 'N/A'))),
                          DataCell(Center(
                              child: Text(student["hostel"] ?? 'N/A',
                                  style: TextStyle(
                                      color: student["hostel"] == 'আবাসিক'
                                          ? Colors.orange[800]
                                          : Colors.teal[700])))),
                          DataCell(Center(child: Text(student["father"] ?? 'N/A'))),
                          DataCell(Center(child: Text(student["phone"] ?? 'N/A'))),
                          DataCell(Center(
                              child: Text(student["transaction"] ?? 'N/A',
                                  style: TextStyle(
                                      color: student["transaction"] == 'পরিশোধ'
                                          ? Colors.green
                                          : Colors.red)))),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}