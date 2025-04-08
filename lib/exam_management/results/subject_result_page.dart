import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import '../exam_common_dropdown_row.dart';
import 'student_result_page.dart';
import 'subject_result_controller.dart';

class SubjectResultPage extends StatefulWidget {
  const SubjectResultPage({Key? key}) : super(key: key);

  @override
  State<SubjectResultPage> createState() => _SubjectResultPageState();
}

class _SubjectResultPageState extends State<SubjectResultPage> {
  final controller = SubjectResultController();
  final TextEditingController marksController = TextEditingController();

  @override
  void dispose() {
    marksController.dispose(); // অবশ্যই dispose করতে হবে
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentResultPage(), // এখানে ResultPage আপনার গন্তব্য পেজ হবে
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
              child: SizedBox(
                width: double.infinity, // Ensure button stretches to full width
                child: const Text(
                  "নির্দিষ্ট শিক্ষার্থীর সকল বিষয়ের রেজাল্ট একসাথে দেখুন",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDropdownRow(),
            const SizedBox(height: 20),
            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return CommonDropdownRow<String>(
      examLabel: "পরীক্ষার নাম",
      examItems: controller.exams,
      selectedExam: controller.selectedExam,
      onExamChanged: (value) {
        setState(() {
          controller.selectExam(value);
        });
      },
      sessionLabel: "শিক্ষাবর্ষ",
      sessionItems: controller.sessions,
      selectedSession: controller.selectedSession,
      onSessionChanged: (value) {
        setState(() {
          controller.selectSession(value);
        });
      },
      classLabel: "ক্লাস",
      classItems: controller.classes,
      selectedClass: controller.selectedClass,
      onClassChanged: (value) {
        setState(() {
          controller.selectClass(value);
        });
      },
      subjectLabel: "বিষয়",
      subjectItems: controller.subjects,
      selectedSubject: controller.selectedSubject,
      onSubjectChanged: (value) {
        setState(() {
          controller.selectSubject(value);
          controller.selectFirstStudent();
        });
      },
    );
  }

  Widget _buildMainContent() {
    return Row(
      children: [
        // Left part: Subject info and students list
        Expanded(
          flex: 2,
          child: _buildStudentMarksInput(),
        ),
        const SizedBox(width: 10),
        Container(
          width: 2,
          color: Colors.yellow,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        const SizedBox(width: 10),
        // Right part: Student marks input and updates
        Expanded(
          flex: 8,
          child: _buildSubjectInfoAndStudentList(),
        ),
      ],
    );
  }

  Widget _buildSubjectInfoAndStudentList() {
    if (controller.selectedSubject == null) {
      return const Center(child: Text("বিষয় নির্বাচন করুন"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // এক রো-তে টেক্সট ও প্রিন্ট আইকন
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "পরীক্ষা: ${controller.selectedExam}, শিক্ষাবর্ষ: ${controller.selectedSession}, ক্লাস: ${controller.selectedClass}, বিষয়: ${controller.selectedSubject}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.print, color: Colors.blue),
              onPressed: () {
                // এখানে পুরো মার্ক সিট প্রিন্ট করা দরকার ওপরে স্কুলের টাইটেল পরে রেজাল্ট টেবিল
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        // শিক্ষার্থীদের তালিকা
        _buildStudentList(),
      ],
    );
  }

  Widget _buildStudentList() {
    if (controller.students.isEmpty) {
      return const Text("এই বিষয়ের জন্য কোনো শিক্ষার্থী নেই।");
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(color: Colors.black),
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFF80D0FF)),
          children: [
            Padding(padding: EdgeInsets.all(8), child: Text("No.", style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text("দাখিলা", style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text("নাম", style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text("প্রাপ্ত নম্বর", style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(padding: EdgeInsets.all(8), child: Text("এডিট", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        ...controller.students.asMap().entries.map((entry) {
          final index = entry.key;
          final student = entry.value;
          return TableRow(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: Text((index + 1).toString())),
              Padding(padding: const EdgeInsets.all(8), child: Text(student.id)),
              Padding(padding: const EdgeInsets.all(8), child: Text(student.name)),
              Padding(padding: const EdgeInsets.all(8), child: Text(student.marks?.toString() ?? "-")),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      controller.selectStudentForMarks(student);
                    });
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildStudentMarksInput() {
    final selectedStudent = controller.selectedStudentForMarks;
    final students = controller.students;

    if (selectedStudent == null) {
      return const Center(child: Text("শিক্ষার্থী নির্বাচন করুন"));
    }

    marksController.text = selectedStudent.marks?.toString() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("শিক্ষার্থী খুঁজুন (নাম বা দাখিলা):"),
        const SizedBox(height: 8),

        // সার্চ ফিল্ড সহ Autocomplete
        Autocomplete<Student>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Student>.empty();
            }
            return students.where((student) {
              final query = textEditingValue.text.toLowerCase();
              return student.name.toLowerCase().contains(query) ||
                  student.id.toLowerCase().contains(query);
            });
          },
          displayStringForOption: (Student student) => "${student.name} (${student.id})",
          onSelected: (Student student) {
            setState(() {
              controller.selectStudentForMarks(student);
              marksController.text = student.marks?.toString() ?? '';
            });
          },
          fieldViewBuilder: (context, textController, focusNode, onEditingComplete) {
            return TextFormField(
              controller: textController,
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
              decoration: InputDecoration(
                hintText: "নাম বা দাখিলা লিখুন",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                isDense: true,
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        Text("শিক্ষার্থী: ${selectedStudent.name} (${selectedStudent.id})"),
        const SizedBox(height: 10),

        TextFormField(
          controller: marksController,
          decoration: InputDecoration(
            labelText: "প্রাপ্ত নম্বর",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            isDense: true,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final marks = int.tryParse(value);
            if (marks != null) {
              setState(() {
                selectedStudent.marks = marks;
                controller.updateMarksForStudent(selectedStudent);
              });
            }
          },
          // যখন এন্টার ক্লিক হবে তখন পরবর্তী শিক্ষার্থী নির্বাচন হবে
          onEditingComplete: () {
            setState(() {
              controller.moveToNextStudent();
            });
          },
        ),

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              controller.moveToNextStudent();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          child: const Text(
            "পরবর্তী শিক্ষার্থী",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}