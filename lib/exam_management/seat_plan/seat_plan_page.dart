import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'seat_plan_controller.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({Key? key}) : super(key: key);

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  final controller = SeatPlanController();

  Map<String, List<RoomData>> allSeatPlans = {};
  final TextEditingController seatCountController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdownRow(),
            const SizedBox(height: 10),
            _buildRoomInputSection(),
            const SizedBox(height: 10),
            _buildRoomListTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      children: [
        Expanded(child: _buildDropdown(
          label: "পরীক্ষার নাম",
          items: controller.exams,
          value: controller.selectedExam,
          onChanged: (value) {
            setState(() {
              controller.selectExam(value);
            });
          },
        )),
        const SizedBox(width: 10),
        Expanded(child: _buildDropdown(
          label: "শিক্ষাবর্ষ",
          items: controller.sessions,
          value: controller.selectedSession,
          onChanged: controller.selectedExam == null ? null : (value) {
            setState(() => controller.selectSession(value as String?));
          },
        )),
        const SizedBox(width: 10),
        Expanded(child: _buildDropdown(
          label: "ক্লাস",
          items: controller.availableClasses,
          value: controller.selectedClass,
          onChanged: controller.selectedSession == null ? null : (value) {
            setState(() => controller.selectClass(value as String?));
          },
        )),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required List<T> items,
    required T? value,
    required Function(T?)? onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // কম উচ্চতা
        isDense: true, // কমপ্যাক্ট ডিজাইন
      ),
      items: items.map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      )).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildRoomInputSection() {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: TextFormField(
            controller: roomController,
            decoration: InputDecoration(
              labelText: "রুম নম্বর",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: TextFormField(
            controller: seatCountController,
            decoration: InputDecoration(
              labelText: "জন",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "যুক্ত করুন",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // বাটনের ব্যাকগ্রাউন্ড রঙ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // কোণার গোলাকৃতি কমিয়ে দেওয়া
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), // আরামদায়ক সাইজ
          ),
          onPressed: controller.selectedExam == null
              ? null
              : () {
            final exam = controller.selectedExam!;
            final room = roomController.text.trim();
            final count = int.tryParse(seatCountController.text);
            if (room.isNotEmpty && count != null) {
              setState(() {
                final list = allSeatPlans[exam] ?? [];
                list.add(RoomData(
                  session: controller.selectedSession,
                  klass: controller.selectedClass,
                  room: room,
                  count: count,
                ));
                allSeatPlans[exam] = list;
                roomController.clear();
                seatCountController.clear();
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildRoomListTable() {
    final exam = controller.selectedExam;
    if (exam == null || allSeatPlans[exam] == null || allSeatPlans[exam]!.isEmpty) {
      return const Text("এই পরীক্ষার জন্য কোনো তালিকা তৈরি করা নেই।");
    }

    final list = allSeatPlans[exam]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row( // টাইটেল রো
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "পরীক্ষা: $exam",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: () => _showPrintOptions(exam),
            )
          ],
        ),
        const SizedBox(height: 10),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(1.5),
            5: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFF80D0FF)),
              children: [
                Padding(padding: EdgeInsets.all(8), child: Text("শিক্ষাবর্ষ", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("ক্লাস", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("রুম নম্বর", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("মোট শিক্ষার্থী", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("অ্যাকশন", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            ...list.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(8), child: Text(item.session ?? "-")),
                  Padding(padding: const EdgeInsets.all(8), child: Text(item.klass ?? "-")),
                  Padding(padding: const EdgeInsets.all(8), child: Text(item.room)),
                  Padding(padding: const EdgeInsets.all(8), child: Text("${item.count}")),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              roomController.text = item.room;
                              seatCountController.text = item.count.toString();
                              list.removeAt(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() => list.removeAt(index));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })
          ],
        )
      ],
    );
  }

  void _showPrintOptions(String exam) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          "প্রিন্ট অপশন - $exam",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.list_alt, color: Colors.blue),
              title: const Text(
                "তালিকা প্রিন্ট",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                // এখানে প্রিন্ট লজিক যাবে
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.chair_alt_outlined, color: Colors.green),
              title: const Text(
                "সিট প্রিন্ট (ক্লাস অনুসারে)",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                // এখানে সিট প্রিন্ট লজিক যাবে
              },
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text(
              "বন্ধ করুন",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
