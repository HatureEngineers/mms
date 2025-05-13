import 'package:flutter/material.dart';

class MonthYearSelector extends StatelessWidget {
  final int selectedMonth;
  final int selectedYear;
  final Function(int month, int year) onChanged;

  const MonthYearSelector({
    required this.selectedMonth,
    required this.selectedYear,
    required this.onChanged,
  });

  final List<Map<String, dynamic>> months = const [
    {'name': 'জানুয়ারি', 'value': 1},
    {'name': 'ফেব্রুয়ারি', 'value': 2},
    {'name': 'মার্চ', 'value': 3},
    {'name': 'এপ্রিল', 'value': 4},
    {'name': 'মে', 'value': 5},
    {'name': 'জুন', 'value': 6},
    {'name': 'জুলাই', 'value': 7},
    {'name': 'আগস্ট', 'value': 8},
    {'name': 'সেপ্টেম্বর', 'value': 9},
    {'name': 'অক্টোবর', 'value': 10},
    {'name': 'নভেম্বর', 'value': 11},
    {'name': 'ডিসেম্বর', 'value': 12},
  ];

  @override
  Widget build(BuildContext context) {
    final List<int> years = List.generate(10, (index) => DateTime.now().year - 5 + index);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // মাস নির্বাচন
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedMonth,
              decoration: InputDecoration(
                labelText: 'মাস',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: months.map((month) {
                return DropdownMenuItem<int>(
                  value: month['value'],
                  child: Text(month['name']),
                );
              }).toList(),
              onChanged: (newMonth) {
                if (newMonth != null) {
                  onChanged(newMonth, selectedYear);
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          // বছর নির্বাচন
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: InputDecoration(
                labelText: 'বছর',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: years.map((year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              onChanged: (newYear) {
                if (newYear != null) {
                  onChanged(selectedMonth, newYear);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
