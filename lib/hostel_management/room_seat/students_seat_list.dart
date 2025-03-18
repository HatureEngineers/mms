import 'package:flutter/material.dart';

class SeatList extends StatefulWidget {
  final List<Map<String, String>> admittedStudents;
  const SeatList({super.key, required this.admittedStudents});

  @override
  _SeatListState createState() => _SeatListState();
}

class _SeatListState extends State<SeatList> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredStudents = widget.admittedStudents
        .where((student) => student['id']!.contains(searchQuery) ||
        student['name']!.contains(searchQuery))
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'হোস্টেলের শিক্ষার্থীর তালিকা',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'দাখিলা নম্বর বা নাম লিখে খুঁজুন...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    prefixIcon: const Icon(Icons.search, size: 20),
                  ),
                  style: const TextStyle(fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(borderRadius: BorderRadius.circular(12)),
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(80),
              2: FlexColumnWidth(),
              3: FixedColumnWidth(80),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FixedColumnWidth(80),
              7: FixedColumnWidth(80),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('No.', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('দাখিলা', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('নাম', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('ক্লাস', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('অভিভাবক', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('ফোন', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('সিট', textAlign: TextAlign.center))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('পেমেন্ট', textAlign: TextAlign.center))),
                ],
              ),
              for (int i = 0; i < filteredStudents.length; i++)
                TableRow(
                  children: [
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text('${i + 1}', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['id'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['name'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['class'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['guardian'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['phone'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['seat'] ?? '', textAlign: TextAlign.center))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8), child: Text(filteredStudents[i]['payment'] ?? '', textAlign: TextAlign.center))),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}