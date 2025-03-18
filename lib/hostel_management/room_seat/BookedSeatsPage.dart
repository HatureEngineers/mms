import 'package:flutter/material.dart';

class BookedSeatsPage extends StatelessWidget {
  final List<String> bookedSeats = [
    'Room 101 - Seat 1',
    'Room 102 - Seat 2',
    'Room 103 - Seat 1',
    'Room 104 - Seat 3',
    'Room 105 - Seat 2'
  ];

  BookedSeatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '📌 Booked Seats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // প্রতি সারিতে ২টি আইটেম
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 3,
                  childAspectRatio: 2.5, // গ্রিড আইটেমের অনুপাত
                ),
                itemCount: bookedSeats.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: ListTile(
                        leading: const Icon(Icons.event_busy, color: Colors.red),
                        title: Text(
                          bookedSeats[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 2),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              label: const Text('Close'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
