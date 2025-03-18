import 'package:flutter/material.dart';
import 'data_provider.dart';

class StudentSelectionPage extends StatefulWidget {
  final Function(String) onStudentSelected;
  const StudentSelectionPage({super.key, required this.onStudentSelected});

  @override
  _StudentSelectionPageState createState() => _StudentSelectionPageState();
}

class _StudentSelectionPageState extends State<StudentSelectionPage> {
  String? selectedYear;
  String? selectedClass;
  String? selectedStudent;

  List<String> filteredClasses = [];
  List<String> filteredStudents = [];

  void filterStudents() {
    Set<String> studentsSet = {};

    if (selectedClass != null) {
      studentsSet.addAll(DataProvider.studentData[selectedClass!] ?? []);
    }

    if (selectedYear != null && selectedClass == null) {
      List<String>? yearClasses = DataProvider.classData[selectedYear!];
      if (yearClasses != null) {
        for (var cls in yearClasses) {
          studentsSet.addAll(DataProvider.studentData[cls] ?? []);
        }
      }
    }

    setState(() {
      filteredStudents = studentsSet.toList();
    });
  }

  void _showAddDialog(String type) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New $type"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter $type name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (type == "Year") {
                    DataProvider.addAcademicYear(controller.text);
                  } else if (type == "Class" && selectedYear != null) {
                    DataProvider.addClass(selectedYear!, controller.text);
                    filteredClasses = DataProvider.classData[selectedYear!]!;
                  } else if (type == "Student" && selectedClass != null) {
                    DataProvider.addStudent(selectedClass!, controller.text);
                    filterStudents();
                  }
                });
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'শিক্ষার্থী নির্বাচন করুন',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // ✅ তিনটি ড্রপডাউন ও "+" আইকন একই লাইনে (Row)
          Row(
            children: [
              // শিক্ষাবর্ষ ড্রপডাউন
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.blue[100],
                    isDense: true, // কম উচ্চতার জন্য
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12), // Padding কমানো
                  ),
                  hint: const Text(
                    'শিক্ষাবর্ষ',
                    textAlign: TextAlign.center, // হিন্ট টেক্সট সেন্টার করা
                  ),
                  value: selectedYear,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                      filteredClasses = value != null ? DataProvider.classData[value]! : [];
                      filterStudents();
                    });
                  },
                  items: DataProvider.academicYears.map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Align(
                        alignment: Alignment.center, // সেন্টার অ্যালাইনমেন্ট দেওয়া হয়েছে
                        child: Text(
                          year,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center, // আইটেম টেক্সট সেন্টার করা
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.blue),
                onPressed: () => _showAddDialog("Year"),
              ),

              SizedBox(width: 10),

              // ক্লাস ড্রপডাউন
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.blue[100],
                    isDense: true, // কম উচ্চতার জন্য
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12), // Padding কমানো
                  ),
                  hint: const Text(
                    'জামাত',
                    textAlign: TextAlign.center, // হিন্ট টেক্সট সেন্টার করা
                  ),
                  value: selectedClass,
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value;
                      filterStudents();
                    });
                  },
                  items: DataProvider.studentData.keys.map((cls) {
                    return DropdownMenuItem<String>(
                      value: cls,
                      child: Align(
                        alignment: Alignment.center, // সেন্টার অ্যালাইনমেন্ট
                        child: Text(
                          cls,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center, // আইটেম টেক্সট সেন্টার করা
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.blue),
                onPressed: selectedYear == null ? null : () => _showAddDialog("Class"),
              ),

              SizedBox(width: 10),

              // স্টুডেন্ট ড্রপডাউন
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.blue[100],
                    isDense: true, // কম উচ্চতার জন্য
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12), // Padding কমানো
                  ),
                  hint: const Text(
                    'শিক্ষার্থী',
                    textAlign: TextAlign.center, // হিন্ট টেক্সট সেন্টার করা
                  ),
                  value: selectedStudent,
                  onChanged: (value) {
                    setState(() {
                      selectedStudent = value;
                    });
                    if (value != null) {
                      widget.onStudentSelected(value);
                    }
                  },
                  items: filteredStudents.map((student) {
                    return DropdownMenuItem<String>(
                      value: student,
                      child: Align(
                        alignment: Alignment.center, // সেন্টার অ্যালাইনমেন্ট
                        child: Text(
                          student,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center, // আইটেম টেক্সট সেন্টার করা
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.blue),
                onPressed: selectedClass == null ? null : () => _showAddDialog("Student"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
