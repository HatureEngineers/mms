import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BranchDropdown extends StatefulWidget {
  final Function(String?)? onChanged;
  final bool showAddIcon;
  final String? selectedBankId;

  const BranchDropdown({super.key, this.onChanged, this.showAddIcon = true, this.selectedBankId});

  @override
  _BranchDropdownState createState() => _BranchDropdownState();
}

class _BranchDropdownState extends State<BranchDropdown> {
  List<String> branches = [];
  String? selectedBranch;

  @override
  void initState() {
    super.initState();
    fetchBranches();
  }

  @override
  void didUpdateWidget(covariant BranchDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedBankId != widget.selectedBankId) {
      setState(() {
        selectedBranch = null; // ✅ নতুন ব্যাংক সিলেক্ট হলে পুরোনো ব্রাঞ্চ ক্লিয়ার হবে
      });
      fetchBranches();
    }
  }

  // ব্যাংকের ওপর নির্ভর করে ব্রাঞ্চ লোড করার ফাংশন
  Future<void> fetchBranches() async {
    if (widget.selectedBankId == null || widget.selectedBankId!.trim().isEmpty) {
      print("⚠ No bank selected!"); // যদি ব্যাংক সিলেক্ট না হয়
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/banking/branches/${widget.selectedBankId}'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (mounted) {
          setState(() {
            branches = data.map((branch) => branch['branch_name'].toString()).toList();
          });
        }
      } else {
      }
    } catch (error) {
      print("❌ Error fetching branches: $error");
    }
  }

// নতুন ব্রাঞ্চ যোগ করার ফাংশন
  Future<void> addBranch(String branchName) async {
    if (widget.selectedBankId == null || widget.selectedBankId!.trim().isEmpty) {
      return;
    }
    if (branchName.trim().isEmpty) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/banking/branches'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "branch_name": branchName.trim(),
          "bank_id": widget.selectedBankId // এখানে bank_id ব্যবহার হচ্ছে
        }),
      );

      if (response.statusCode == 201) {
        if (mounted) {
          setState(() {
            branches.add(branchName);
            selectedBranch = branchName;
          });
        }
        if (widget.onChanged != null) {
          widget.onChanged!(branchName);
        }
      } else {
      }
    } catch (error) {
      print("❌ Error adding branch: $error");
    }
  }

  void _showAddBranchDialog() {
    TextEditingController branchController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('নতুন ব্রাঞ্চ যোগ করুন'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: branchController,
                decoration: const InputDecoration(
                  labelText: 'ব্রাঞ্চের নাম',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String newBranch = branchController.text.trim();
                  if (newBranch.isNotEmpty && !branches.contains(newBranch)) {
                    addBranch(newBranch);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
            child: DropdownButtonFormField<String>(
              value: selectedBranch,
              hint: const Text('ব্রাঞ্চ নির্বাচন করুন'),
              items: branches.map((branch) {
                return DropdownMenuItem(value: branch, child: Text(branch));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBranch = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value ?? "");
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                isDense: true,
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          if (widget.showAddIcon) ...[
            const SizedBox(width: 2),
            InkWell(
              onTap: _showAddBranchDialog,
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
