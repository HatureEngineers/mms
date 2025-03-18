import 'package:flutter/material.dart';

class AvailableSeatsPage extends StatelessWidget {
  final List<String> availableSeats = [
    'Room 101 - Seat 2',
    'Room 102 - Seat 1',
    'Room 102 - Seat 3',
    'Room 103 - Seat 4',
    'Room 104 - Seat 5',
  ];

  AvailableSeatsPage({super.key});

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
              '✅ Available Seats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // প্রতি সারিতে ২টি আইটেম
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2.5, // গ্রিড আইটেমের অনুপাত
                ),
                itemCount: availableSeats.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: ListTile(
                        leading: const Icon(Icons.event_available, color: Colors.green),
                        title: Text(
                          availableSeats[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // বোল্ড বাদ দেওয়া হয়েছে
                            fontSize: 12, // টেক্সট সাইজ কমিয়ে দেওয়া হয়েছে
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              label: const Text('Close'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
