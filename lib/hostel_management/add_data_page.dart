import 'package:flutter/material.dart';
import 'data_provider.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();

  String? selectedYearForClass;
  String? selectedClassForStudent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // নতুন শিক্ষাবর্ষ যোগ করুন
            TextField(
              controller: _yearController,
              decoration: InputDecoration(
                labelText: "Add Academic Year",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_yearController.text.isNotEmpty) {
                  setState(() {
                    DataProvider.addAcademicYear(_yearController.text);
                  });
                  _yearController.clear();
                }
              },
              child: Text("Add Year"),
            ),

            const SizedBox(height: 20),

            // নতুন ক্লাস যোগ করুন
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Year for Class",
                border: OutlineInputBorder(),
              ),
              value: selectedYearForClass,
              onChanged: (value) {
                setState(() {
                  selectedYearForClass = value;
                });
              },
              items: DataProvider.academicYears.map((year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _classController,
              decoration: InputDecoration(
                labelText: "Add Class",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedYearForClass != null && _classController.text.isNotEmpty) {
                  setState(() {
                    DataProvider.addClass(selectedYearForClass!, _classController.text);
                  });
                  _classController.clear();
                }
              },
              child: Text("Add Class"),
            ),

            const SizedBox(height: 20),

            // নতুন স্টুডেন্ট যোগ করুন
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Class for Student",
                border: OutlineInputBorder(),
              ),
              value: selectedClassForStudent,
              onChanged: (value) {
                setState(() {
                  selectedClassForStudent = value;
                });
              },
              items: DataProvider.studentData.keys.map((cls) {
                return DropdownMenuItem<String>(
                  value: cls,
                  child: Text(cls),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _studentController,
              decoration: InputDecoration(
                labelText: "Add Student",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedClassForStudent != null && _studentController.text.isNotEmpty) {
                  setState(() {
                    DataProvider.addStudent(selectedClassForStudent!, _studentController.text);
                  });
                  _studentController.clear();
                }
              },
              child: Text("Add Student"),
            ),
          ],
        ),
      ),
    );
  }
}
