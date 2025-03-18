import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import '../data_provider.dart';
import '../student_selection_page.dart';
import 'guardian_list.dart';
import 'leave_record.dart';

class GuardianAndLeave extends StatefulWidget {
  const GuardianAndLeave({super.key});

  @override
  _GuardianAndLeaveState createState() => _GuardianAndLeaveState();
}

class _GuardianAndLeaveState extends State<GuardianAndLeave> {
  String? selectedStudent;
  List<Map<String, String>> guardians = [];
  bool showGuardians = false;
  Map<String, List<Map<String, dynamic>>> leaveRecords = {};

  // Leave প্যানেলের জন্য ভ্যারিয়েবল
  bool showLeavePanel = false;
  DateTime? leaveFromDate;
  DateTime? leaveToDate;
  TextEditingController leaveProviderController = TextEditingController();

  void _onStudentSelected(String student) {
    setState(() {
      selectedStudent = student;
      guardians = DataProvider.getGuardiansForStudent(student);
    });
  }

  void _showAddGuardianDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController relationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Add New Guardian"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameController, "Guardian Name"),
              _buildTextField(phoneController, "Phone Number"),
              _buildTextField(relationController, "Relation"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  guardians.add({
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'relation': relationController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Guardian added successfully!")),
                );
              },
              child: const Text("Add Guardian"),
            ),
          ],
        );
      },
    );
  }

  // Function to select visit date
  void _selectVisitDate(int index) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        guardians[index]['visitDate'] = pickedDate.toString().split(' ')[0];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Visit date updated!")),
      );
    }
  }

  // Function to delete guardian
  void _deleteGuardian(int index) {
    setState(() {
      guardians.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Guardian deleted successfully!")),
    );
  }

  // Function to edit guardian
  void _showEditGuardianDialog(int index) {
    TextEditingController nameController = TextEditingController(text: guardians[index]['name']);
    TextEditingController phoneController = TextEditingController(text: guardians[index]['phone']);
    TextEditingController relationController = TextEditingController(text: guardians[index]['relation']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Edit Guardian"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameController, "Guardian Name"),
              _buildTextField(phoneController, "Phone Number"),
              _buildTextField(relationController, "Relation"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  guardians[index] = {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'relation': relationController.text,
                  };
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Guardian updated successfully!")),
                );
              },
              child: const Text("Save Changes"),
            ),
          ],
        );
      },
    );
  }

  // Leave রেকর্ড করার ফাংশন (নতুন: provider নামও যুক্ত)
  void _recordLeave() {
    if (selectedStudent == null || leaveFromDate == null || leaveToDate == null) return;
    String leaveProvider = leaveProviderController.text;
    setState(() {
      leaveRecords.putIfAbsent(selectedStudent!, () => []);
      leaveRecords[selectedStudent!]!.add({
        'startDate': leaveFromDate.toString().split(' ')[0],
        'endDate': leaveToDate.toString().split(' ')[0],
        'provider': leaveProvider,
      });
      // Leave প্যানেল রিসেট
      showLeavePanel = false;
      leaveFromDate = null;
      leaveToDate = null;
      leaveProviderController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Leave recorded from ${leaveRecords[selectedStudent!]!.last['startDate']} to ${leaveRecords[selectedStudent!]!.last['endDate']} by $leaveProvider"
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.blue[50],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Student selection page
                StudentSelectionPage(onStudentSelected: _onStudentSelected),

                if (selectedStudent != null) ...[
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  // Example Student Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/student.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.person, size: 50, color: Colors.teal),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Student info (image, name, admission)
                  Text(
                    'শিক্ষার্থী: $selectedStudent',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 1),
                  Text('দাখেলা: ${DataProvider.getAdmissionForStudent(selectedStudent!)}'),
                  // const SizedBox(height: 1),
                  // Text('সিট: ${DataProvider.getRoomAndSeatNumber(selectedSeat!)}'), //ekhane rum number o seat number dekhaile valo hoy
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Guardians Button (টগল হবে)
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            showGuardians = !showGuardians;
                          });
                        },
                        icon: const Icon(Icons.group, color: Colors.white),
                        label: const Text(
                          "অভিভাবক",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          shadowColor: Colors.blueAccent.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Leave Button: Leave প্যানেল দেখাবে
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            showLeavePanel = true;
                          });
                        },
                        icon: const Icon(Icons.event_busy, color: Colors.white),
                        label: const Text(
                          "ছুটি",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          shadowColor: Colors.redAccent.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),

                  // Guardians Grid
                  if (showGuardians)
                    GuardianGrid(
                      guardians: guardians,
                      onDelete: _deleteGuardian,
                      onEdit: _showEditGuardianDialog,
                      onSelectDate: _selectVisitDate,
                      onAddGuardian: _showAddGuardianDialog,
                    ),

                  // Leave প্যানেল – এক রো-তে দুইটি পিকার ও ১টি টেক্সট ফিল্ড
                  if (showLeavePanel) ...[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                leaveFromDate = pickedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
                          label: Text(
                            leaveFromDate == null
                                ? "ছুটি শুরুর তারিখ"
                                : DateFormat('dd MMM yyyy').format(leaveFromDate!),  // সিলেক্ট করা তারিখ দেখানো
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            DateTime initial = leaveFromDate ?? DateTime.now();
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: initial,
                              firstDate: initial,
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                leaveToDate = pickedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_month_sharp, color: Colors.white),
                          label: Text(
                            leaveToDate == null
                                ? "ছুটি শেষের তারিখ"
                                : DateFormat('dd MMM yyyy').format(leaveToDate!),  // সিলেক্ট করা তারিখ দেখানো
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // নতুন: TextField, যেখানে কে ছুটি দিচ্ছেন তার নাম লিখবে
                        SizedBox(
                          width: 200,  // আপনার প্রয়োজন অনুযায়ী প্রস্থ নির্ধারণ করুন
                          child: TextField(
                            controller: leaveProviderController,
                            decoration: InputDecoration(
                              labelText: "ছুটি দানকারীর নাম",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (leaveFromDate != null && leaveToDate != null)
                      ElevatedButton(
                        onPressed: _recordLeave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          "Record Leave",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],

                  // Leave Records Section
                  LeaveRecords(
                    leaveRecords: leaveRecords,
                    selectedStudent: selectedStudent!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
