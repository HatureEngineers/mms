import 'package:flutter/material.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // চারপাশে কিছু প্যাডিং যোগ করা
      child: Wrap(
        spacing: 16.0, // অনুভূমিক গ্যাপ
        runSpacing: 16.0, // উল্লম্ব গ্যাপ
        alignment: WrapAlignment.center, // বাটনগুলো সেন্টারে থাকবে
        children: [
          // _buildButton(Icons.dashboard, "Dashboard", Colors.indigoAccent),
          _buildButton(Icons.people, "শিক্ষার্থী", Colors.green),
          _buildButton(Icons.person, "স্টাফ", Colors.green),
          _buildButton(Icons.payment, "পরীক্ষা", Colors.green),
          _buildButton(Icons.note_alt, "রিপোর্ট", Colors.green),
          _buildButton(Icons.monetization_on_sharp, "বেতন", Colors.green),
          _buildButton(Icons.help, "হেল্প", Colors.green),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, Color color) {
    return ElevatedButton.icon(
      onPressed: () {}, // আপাতত কোনো কাজ করবে না
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
