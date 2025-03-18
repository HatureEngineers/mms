import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BankDropdown extends StatefulWidget {
  final Function(String?)? onChanged;
  final bool showAddIcon;

  const BankDropdown({super.key, this.onChanged, this.showAddIcon = true});

  @override
  _BankDropdownState createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  List<Map<String, dynamic>> banks = []; // ব্যাংক লিস্টটিকে Map হিসেবে পরিবর্তন করুন
  int? selectedBank; // selectedBank কে int? টাইপে পরিবর্তন করুন

  @override
  void initState() {
    super.initState();
    fetchBanks();
  }

  // ব্যাংকের নামের তালিকা লোড করার ফাংশন
  Future<void> fetchBanks() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/banking/banks'), // আপনার আইপি ঠিকানা
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          banks = data.map((bank) => {
            'id': bank['id'],
            'bank_name': bank['bank_name'],
          }).toList();
        });
      } else {}
    } catch (e) {
      print("API Fetch Error: $e");
    }
  }

  // নতুন ব্যাংকের নাম সংরক্ষণের ফাংশন
  Future<void> addBank(String bankName) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/banking/banks'), // আপনার আইপি ঠিকানা
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"bank_name": bankName}),
      );

      if (response.statusCode == 201) {
        setState(() {
          banks.add({'id': banks.length + 1, 'bank_name': bankName}); // নতুন ব্যাংক লিস্টে যোগ হবে
        });
      } else {}
    } catch (e) {
      print("Failed to add bank: $e");
    }
  }

  void _showAddBankDialog() {
    TextEditingController bankController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('নতুন ব্যাংক যোগ করুন'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bankController,
                decoration: const InputDecoration(
                  labelText: 'ব্যাংকের নাম',
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String newBank = bankController.text.trim();
                  if (newBank.isNotEmpty && !banks.any((bank) => bank['bank_name'] == newBank)) {
                    addBank(newBank);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                child: const Text(
                  'সংরক্ষণ করুন',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedBank, // সরাসরি int value ব্যবহার করুন
              hint: const Text('ব্যাংক নির্বাচন করুন'),
              items: banks.map((bank) {
                return DropdownMenuItem<int>(
                  value: bank['id'], // এখানে 'id' কে সরাসরি int পাঠানো হচ্ছে
                  child: Text(bank['bank_name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value; // value সরাসরি int এ সেট করুন
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value?.toString());
                }
              },
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                isDense: true,
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                  const BorderSide(color: Colors.blueGrey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          if (widget.showAddIcon) ...[
            // ✅ showAddIcon থাকলে "+" আইকন দেখাবে
            const SizedBox(width: 2),
            InkWell(
              onTap: _showAddBankDialog,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
