import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import '../exam_common_dropdown_row.dart';
import 'student_result_controller.dart';

class StudentResultPage extends StatefulWidget {
  @override
  _StudentResultPageState createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  late StudentResultController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = StudentResultController();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonDropdownRow<String>(
                examLabel: 'পরীক্ষার নাম',
                examItems: _controller.exams,
                selectedExam: _controller.selectedExam,
                onExamChanged: (value) {
                  setState(() {
                    _controller.selectedExam = value;
                    _controller.clearSelectedStudent();
                  });
                },
                sessionLabel: 'শিক্ষাবর্ষ',
                sessionItems: _controller.sessions,
                selectedSession: _controller.selectedSession,
                onSessionChanged: (value) {
                  setState(() {
                    _controller.selectedSession = value;
                    _controller.clearSelectedStudent();
                  });
                },
                classLabel: 'ক্লাস',
                classItems: _controller.classes,
                selectedClass: _controller.selectedClass,
                onClassChanged: (value) {
                  setState(() {
                    _controller.selectedClass = value;
                    _controller.clearSelectedStudent();
                  });
                },
                subjectLabel: null,
                subjectItems: null,
                selectedSubject: null,
                onSubjectChanged: null,
              ),

              const SizedBox(height: 20),

              if (_controller.canSearchStudents)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("শিক্ষার্থী নির্বাচন করুন", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'শিক্ষার্থীর নাম বা দাখেলা লিখুন',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        isDense: true,
                      ),
                      onChanged: (query) {
                        setState(() {
                          _controller.filterStudents(query);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _controller.filteredStudents.map((student) {
                        return ChoiceChip(
                          label: Text(student.name),
                          selected: _controller.selectedStudent == student,
                          onSelected: (_) {
                            setState(() {
                              _controller.selectStudent(student);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              if (_controller.selectedStudent != null)
                Center(
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${_controller.selectedExam} (${_controller.selectedSession})", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("নাম: ${_controller.selectedStudent!.name}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          Text("ক্লাস: ${_controller.selectedClass}, দাখেলা: ${_controller.selectedStudent!.roll}", style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),

              if (_controller.selectedStudent != null)
                _buildResultTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultTable() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(top: 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(50),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(150),
            3: FixedColumnWidth(150),
            4: FixedColumnWidth(150),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Color(0xFF80D0FF)),
              children: [
                _buildTableHeader('No.'),
                _buildTableHeader('বিষয়'),
                _buildTableHeader('নম্বর'),
                _buildTableHeader('গ্রেড'),
                _buildTableHeader('জিপিএ'),
              ],
            ),
            ..._controller.results.map((result) {
              return TableRow(
                children: [
                  _buildTableCell(result['no'] ?? ''),
                  _buildTableCell(result['subject'] ?? ''),
                  _buildTableCell(result['marks'] ?? ''),
                  _buildTableCell(result['grade'] ?? ''),
                  _buildTableCell(result['gpa'] ?? ''),
                ],
              );
            }).toList(),
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFE0F7FA)),
              children: [
                _buildTableCell('মোট'),
                _buildTableCell(''),
                _buildTableCell(_controller.totalMarks.toString()),
                _buildTableCell(_controller.averageGrade),
                _buildTableCell(_controller.averageGPA),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
