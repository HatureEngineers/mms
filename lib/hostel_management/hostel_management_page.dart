import 'package:flutter/material.dart';
import '../drawer/main_layout_fixedDrawer.dart';
import 'room_seat/hostel_seats.dart';
import 'student_selection_page.dart';
import 'room_seat/students_seat_list.dart';

class HostelManagementPage extends StatefulWidget {
  const HostelManagementPage({super.key});

  @override
  _HostelManagementPageState createState() => _HostelManagementPageState();
}

class _HostelManagementPageState extends State<HostelManagementPage> {
  String? selectedStudent;
  List<Map<String, String>> admittedStudents = [];

  void addStudent(Map<String, String> studentData) {
    setState(() {
      admittedStudents.add(studentData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SingleChildScrollView(  // পুরো পেজ স্ক্রলেবল করার জন্য
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              // Column Layout - উপরে Student Selection, নিচে Admission Form
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Selection Page (উপরে থাকবে)
                      StudentSelectionPage(
                        onStudentSelected: (student) {
                          setState(() {
                            selectedStudent = student;
                          });
                        },
                      ),
                      const SizedBox(height: 1), // মাঝখানে গ্যাপ

                      // Admission Form (নিচে থাকবে, শুধু যদি স্টুডেন্ট সিলেক্ট করা হয়)
                      if (selectedStudent != null)
                        HostelSeats(
                          student: selectedStudent!,
                          onAdmit: addStudent,
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 1),

              // Seat List (ইতিমধ্যে ভর্তি হওয়া শিক্ষার্থীদের তালিকা)
              Card(
                margin: const EdgeInsets.only(top: 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SeatList(admittedStudents: admittedStudents),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
