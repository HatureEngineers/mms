import 'package:flutter/material.dart';

class HostelSeats extends StatefulWidget {
  final String student;
  final Function(Map<String, String>) onAdmit;

  const HostelSeats({super.key, required this.student, required this.onAdmit});

  @override
  _HostelSeatsState createState() => _HostelSeatsState();
}

class _HostelSeatsState extends State<HostelSeats> {
  final List<String> rooms = ['Room 101', 'Room 102', 'Room 103'];
  final Map<String, List<String>> seats = {
    'Room 101': ['Seat 1', 'Seat 2'],
    'Room 102': ['Seat 1', 'Seat 2', 'Seat 3'],
    'Room 103': ['Seat 1'],
  };
  String? selectedRoom;
  String? selectedSeat;
  TextEditingController roomController = TextEditingController();
  TextEditingController seatController = TextEditingController();

  // রুম এবং সিট যোগ করার জন্য ফাংশন
  void addRoomAndSeat() {
    String newRoom = roomController.text.trim();
    String newSeat = seatController.text.trim();

    if (newRoom.isNotEmpty && newSeat.isNotEmpty) {
      setState(() {
        // নতুন রুম এবং সিট যোগ করা
        if (!rooms.contains(newRoom)) {
          rooms.add(newRoom);  // নতুন রুম যদি আগে না থাকে
        }
        if (seats.containsKey(newRoom)) {
          seats[newRoom]!.add(newSeat); // রুমে সিট যোগ করা
        } else {
          seats[newRoom] = [newSeat]; // নতুন রুমের জন্য সিট তৈরি করা
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Room $newRoom with Seat $newSeat added.')),
      );
      roomController.clear();  // ইনপুট ফিল্ড ক্লিয়ার করা
      seatController.clear();  // ইনপুট ফিল্ড ক্লিয়ার করা
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both room and seat.')),
      );
    }
  }

  void showAddRoomDialog() {
    TextEditingController roomController = TextEditingController();
    TextEditingController seatController = TextEditingController();
    bool isRoomFilled = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('রুম ও সিট নম্বর যুক্ত করুন'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Room Number Input
                  TextField(
                    controller: roomController,
                    onChanged: (value) {
                      setState(() {
                        isRoomFilled = value.trim().isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'রুম নম্বর লিখুন *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Seat Number Input
                  TextField(
                    controller: seatController,
                    decoration: InputDecoration(
                      labelText: 'সিট নম্বর লিখুন',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // ক্লোজ পপ-আপ
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: isRoomFilled
                      ? () {
                    addRoomAndSeat(); // ✅ শুধুমাত্র রুম নম্বর থাকলেই ফাংশন কল হবে
                    Navigator.of(context).pop();
                  }
                      : null, // ❌ রুম নম্বর না থাকলে disabled থাকবে
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey; // Disabled হলে গ্রে রঙ দেখাবে
                        }
                        return Colors.deepPurple; // Active হলে নীল রঙ
                      },
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.01),
      child: Column(
        children: [
          // Row for Room, Seat selection, and the "+" icon
          Row(
            children: [
              // Text(
              //   'Selected Student: ${widget.student}',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(width: 12),
              // Room Dropdown
              Expanded(
                child: Container(
                  height: 40, // উচ্চতা কমিয়ে দেওয়া হলো
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                      border: Border.all(color: Colors.black87, width: 1),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text(
                      'Select a Room',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: selectedRoom,
                    onChanged: (value) {
                      setState(() {
                        selectedRoom = value;
                        selectedSeat = null;
                      });
                    },
                    isExpanded: true,
                    underline: Container(), // ডিফল্ট আন্ডারলাইন সরানো
                    iconSize: 24, // ড্রপডাউন আইকনের সাইজ কমানো
                    style: TextStyle(color: Colors.black),
                    items: rooms.map((room) {
                      return DropdownMenuItem<String>(
                        value: room,
                        child: Text(room),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 12), // Space between dropdowns

              // Seat Dropdown (only visible if room is selected)
              if (selectedRoom != null)
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.black87, width: 1),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('Select a Seat', style: TextStyle(color: Colors.black)),
                      value: selectedSeat,
                      onChanged: (value) {
                        setState(() {
                          selectedSeat = value;
                        });
                      },
                      isExpanded: true,
                      underline: Container(),
                      style: TextStyle(color: Colors.black),
                      items: seats[selectedRoom!]!.map((seat) {
                        return DropdownMenuItem<String>(
                          value: seat,
                          child: Text(seat),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              const SizedBox(width: 1), // Space for "+" icon

              // "+" Icon to add Room/Seat
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.blue, size: 32),
                onPressed: showAddRoomDialog, // এখানে ফাংশন কল করা হচ্ছে
              ),
              const SizedBox(width: 2), // Space between icon and button

              // Confirm Admission Button (in the same row)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // button color
                  foregroundColor: Colors.white, // text color
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                onPressed: selectedRoom != null && selectedSeat != null
                    ? () {
                  Map<String, String> studentData = {
                    'id': 'ID123', // এখানে বাস্তব ID বসবে
                    'name': widget.student,
                    'phone': '0123456789', // এখানে বাস্তব ফোন নাম্বার বসবে
                    'class': 'Class 10', // এখানে বাস্তব ক্লাস বসবে
                    'guardian': 'Abba', // এখানে বাস্তব ক্লাস বসবে
                    'seat': 'R-${selectedRoom!.split(' ')[1]}, S-${selectedSeat!.split(' ')[1]}',
                    'payment': 'Paid',
                  };

                  widget.onAdmit(studentData); // শিক্ষার্থী যুক্ত করা

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student ${widget.student} assigned to $selectedRoom, $selectedSeat')),
                  );
                }
                    : null,
                child: const Text('Confirm Admission'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
