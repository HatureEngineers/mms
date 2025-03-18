import 'package:flutter/material.dart';
import 'AvailableSeatsPage.dart';
import 'BookedSeatsPage.dart';

class RoomAndSeat extends StatefulWidget {
  const RoomAndSeat({super.key});

  @override
  _RoomAndSeatState createState() => _RoomAndSeatState();
}

class _RoomAndSeatState extends State<RoomAndSeat> {
  final List<String> rooms = ['Room 101', 'Room 102', 'Room 103'];
  final Map<String, List<String>> seats = {
    'Room 101': ['Seat 1', 'Seat 2'],
    'Room 102': ['Seat 1', 'Seat 2', 'Seat 3'],
    'Room 103': ['Seat 1'],
  };
  final Map<String, String> bookedSeats = {};

  int getTotalSeats() => seats.values.fold(0, (sum, roomSeats) => sum + roomSeats.length);
  int getBookedSeats() => bookedSeats.length;
  int getAvailableSeats() => getTotalSeats() - getBookedSeats();

  TextEditingController roomController = TextEditingController();
  TextEditingController seatController = TextEditingController();

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

  // ডায়ালগটি দেখানোর ফাংশন
  void showAddRoomDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Room and Seat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Room Number Input
              TextField(
                controller: roomController,
                decoration: InputDecoration(
                  labelText: 'Enter Room Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Seat Number Input
              TextField(
                controller: seatController,
                decoration: InputDecoration(
                  labelText: 'Enter Seat Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addRoomAndSeat();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showBookedSeatsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4, // Responsive Width
              maxHeight: MediaQuery.of(context).size.height * 0.5, // Responsive Height
            ),
            child: BookedSeatsPage(), // পপআপে "Booked Seats" পেজ দেখাবে
          ),
        );
      },
    );
  }

  void showAvailableSeatsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: AvailableSeatsPage(), // পপআপে "Available Seats" পেজ দেখাবে
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **শিরোনাম**
              Center(
                child: Text(
                  '🏠 Room & Seat Management',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// **GridView (এক রোতে দুইটি কার্ড)**
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // প্রতিটি রোতে ২টি আইটেম
                  crossAxisSpacing: 5, // দুই কার্ডের মধ্যে গ্যাপ
                  mainAxisSpacing: 5, // উপরে-নিচে গ্যাপ
                  shrinkWrap: true,
                  childAspectRatio: 1.6, // কার্ডের অনুপাত (উচ্চতা ও প্রস্থ)
                  children: [
                    _buildClickableCard('Total Rooms', rooms.length.toString(), Icons.meeting_room, showAddRoomDialog),
                    _buildClickableCard('Total Seats', getTotalSeats().toString(), Icons.bed_sharp, showAddRoomDialog),
                    _buildClickableCard('Booked Seats', getBookedSeats().toString(), Icons.event_busy, showBookedSeatsDialog),
                    _buildClickableCard('Available Seats', getAvailableSeats().toString(), Icons.event_available, showAvailableSeatsDialog),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// **Close Button**
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  label: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **কার্ড ডিজাইন**
  Widget _buildClickableCard(String title, String value, IconData icon, Function onTapAction) {
    return GestureDetector(
      onTap: () {
        onTapAction();  // ক্লিক করার পর নির্দিষ্ট ফাংশন কল হবে
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue.shade600),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
