import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveRecords extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> leaveRecords;
  final String selectedStudent;

  const LeaveRecords({
    super.key,
    required this.leaveRecords,
    required this.selectedStudent,
  });

  @override
  Widget build(BuildContext context) {
    if (!leaveRecords.containsKey(selectedStudent)) {
      return const SizedBox();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'ছুটির রেকর্ড:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.deepOrange,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: leaveRecords[selectedStudent]!.map<Widget>((record) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ছুটি দানকারীর নাম প্রদর্শন
                      Text(
                        'ছুটি দানকারীর ${record['provider'] ?? ''}:',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // "From" কার্ড
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'ছুটি শুরু: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(DateTime.parse(record['startDate'])),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.blue),
                      const SizedBox(width: 8),
                      // "To" কার্ড
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'ছুটি শেষ: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(DateTime.parse(record['endDate'])),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
