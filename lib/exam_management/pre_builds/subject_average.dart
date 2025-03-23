import 'package:flutter/material.dart';

class SubjectAverage extends StatefulWidget {
  const SubjectAverage({super.key});

  @override
  State<SubjectAverage> createState() => _SubjectAverageState();
}

class _SubjectAverageState extends State<SubjectAverage> {
  final TextEditingController _maxMarksController = TextEditingController();
  final TextEditingController _minMarksController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();

  final List<Map<String, dynamic>> _gradingList = [];

  void _addOrUpdateGrade({int? index}) {
    int? maxMarks = int.tryParse(_maxMarksController.text.trim());
    int? minMarks = int.tryParse(_minMarksController.text.trim());
    String grade = _gradeController.text.trim();
    String? gpa = _gpaController.text.trim().isNotEmpty ? _gpaController.text.trim() : "-";

    if (maxMarks != null && minMarks != null && grade.isNotEmpty) {
      setState(() {
        if (index != null) {
          _gradingList[index] = {
            "maxMarks": maxMarks,
            "minMarks": minMarks,
            "grade": grade,
            "gpa": gpa,
          };
        } else {
          _gradingList.add({
            "maxMarks": maxMarks,
            "minMarks": minMarks,
            "grade": grade,
            "gpa": gpa,
          });
        }
        _clearFields();
      });
    }
  }

  void _editGrade(int index) {
    setState(() {
      _maxMarksController.text = _gradingList[index]["maxMarks"].toString();
      _minMarksController.text = _gradingList[index]["minMarks"].toString();
      _gradeController.text = _gradingList[index]["grade"];
      _gpaController.text = _gradingList[index]["gpa"].toString();
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("গ্রেড এডিট করুন"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _maxMarksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "সর্বোচ্চ নম্বর"),
            ),
            TextField(
              controller: _minMarksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "সর্বনিন্ম নম্বর"),
            ),
            TextField(
              controller: _gradeController,
              decoration: const InputDecoration(labelText: "গ্রেড"),
            ),
            TextField(
              controller: _gpaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "জিপিএ"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("বাতিল"),
          ),
          ElevatedButton(
            onPressed: () {
              _addOrUpdateGrade(index: index);
              Navigator.pop(context);
            },
            child: const Text("আপডেট"),
          ),
        ],
      ),
    );
  }

  void _deleteGrade(int index) {
    setState(() {
      _gradingList.removeAt(index);
    });
  }

  void _clearFields() {
    _maxMarksController.clear();
    _minMarksController.clear();
    _gradeController.clear();
    _gpaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "রেজাল্ট সিস্টেম সেট করুন",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // সর্বোচ্চ ও সর্বনিম্ন নম্বর ফিল্ড
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _maxMarksController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "সর্বোচ্চ নম্বর",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // উচ্চতা কমানো
                            isDense: true, // ইনপুট ফিল্ড কম্প্যাক্ট করা
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _minMarksController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "সর্বনিন্ম নম্বর",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // গ্রেড ও জিপিএ ফিল্ড
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _gradeController,
                          decoration: InputDecoration(
                            labelText: "গ্রেড",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _gpaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "জিপিএ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // **সেভ করুন বাটন**
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _addOrUpdateGrade(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // সবুজ রঙ
                        foregroundColor: Colors.white, // সাদা টেক্সট
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10), // কম উচ্চতার বাটন
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // হালকা গোলাকার কোণা
                        ),
                      ),
                      child: const Text("সেভ করুন", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(width: 20, thickness: 1),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "সেভ করা গ্রেডিং সিস্টেম",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                          child: DataTable(
                            columnSpacing: 20,
                            headingRowHeight: 40,
                            dataRowHeight: 50,
                            border: TableBorder(
                              top: BorderSide(color: Colors.grey.shade400, width: 1),  // উপরের বর্ডার
                              bottom: BorderSide(color: Colors.grey.shade400, width: 1), // নিচের বর্ডার
                              left: BorderSide(color: Colors.grey.shade400, width: 1),  // বাম বর্ডার
                              right: BorderSide(color: Colors.grey.shade400, width: 1), // ডান বর্ডার
                              horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1), // সারির মধ্যে দাগ
                              verticalInside: BorderSide(color: Colors.grey.shade300, width: 1), // কলামের মধ্যে দাগ
                            ),
                            headingTextStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87
                            ),
                            dataTextStyle: const TextStyle(
                                fontSize: 15, color: Colors.black87
                            ),
                            columns: [
                              DataColumn(label: Center(child: Text("প্রাপ্ত নম্বর"))),
                              DataColumn(label: Center(child: Text("গ্রেড"))),
                              DataColumn(label: Center(child: Text("জিপিএ"))),
                              DataColumn(label: Center(child: Text("অপশন"))),
                            ],
                            rows: _gradingList.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> grade = entry.value;
                              return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                    return index.isEven ? Colors.grey.shade100 : null;
                                  },
                                ),
                                cells: [
                                  DataCell(Center(child: Text("${grade['maxMarks']} - ${grade['minMarks']}"))),
                                  DataCell(Center(child: Text(grade["grade"]))),
                                  DataCell(Center(child: Text(grade["gpa"]))),
                                  DataCell(
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            onPressed: () => _editGrade(index),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () => _deleteGrade(index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
