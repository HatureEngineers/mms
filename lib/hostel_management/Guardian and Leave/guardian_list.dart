import 'package:flutter/material.dart';

class GuardianGrid extends StatelessWidget {
  final List<Map<String, String>> guardians;
  final Function(int) onDelete;
  final Function(int) onSelectDate;
  final Function(int) onEdit;
  final VoidCallback onAddGuardian;

  const GuardianGrid({
    super.key,
    required this.guardians,
    required this.onDelete,
    required this.onSelectDate,
    required this.onEdit,
    required this.onAddGuardian,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Guardians:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // এক রো-তে ৩টি আইটেম দেখাবে
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5, // গার্ডিয়ান কার্ডের উচ্চতা ঠিক রাখবে
            ),
            itemCount: guardians.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guardians[index]['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text('Relation: ${guardians[index]['relation']}'),
                      Text('Phone: ${guardians[index]['phone']}'),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => onDelete(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => onEdit(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_month_sharp, color: Colors.deepPurpleAccent),
                              onPressed: () => onSelectDate(index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.add_circle, color: Colors.white),
          label: const Text(
            "Add Guardian",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onAddGuardian,
        ),
      ],
    );
  }
}
