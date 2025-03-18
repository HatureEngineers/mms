import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../bank_dropdown.dart';
import '../branch_dropdown.dart';

class BankForm extends StatefulWidget {
  final Function(Map<String, String>) onSave;
  const BankForm({super.key, required this.onSave});

  @override
  _BankFormState createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  String? selectedBank;
  String? selectedBranch;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedBranch == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ দয়া করে ব্রাঞ্চ নির্বাচন করুন!")),
        );
        return; // ✅ ব্রাঞ্চ না থাকলে API কল বন্ধ করে দিন
      }

      var url = Uri.parse("http://localhost:3000/banking/add-bank");

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "bank_id": selectedBank != null ? int.tryParse(selectedBank!) : null,
          "branch_id": selectedBranch != null ? int.tryParse(selectedBranch!) : null,
          "account_holder": accountHolderController.text.trim(),
          "account_number": accountNumberController.text.trim(),
          "balance": balanceController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ ব্যাংক অ্যাকাউন্ট সফলভাবে যোগ হয়েছে!")),
        );

        widget.onSave({
          "accountHolder": accountHolderController.text.trim(),
          "accountNumber": accountNumberController.text.trim(),
          "balance": balanceController.text.trim(),
          "bankName": selectedBank ?? '',
          "branchName": selectedBranch ?? '',
        });

        accountHolderController.clear();
        accountNumberController.clear();
        balanceController.clear();
        setState(() {
          selectedBank = null;
          selectedBranch = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.005;
    bool isWide = MediaQuery.of(context).size.width > 600;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: BankDropdown(
                    onChanged: (bank) {
                      setState(() {
                        selectedBank = bank;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: BranchDropdown(
                    selectedBankId: selectedBank,
                    onChanged: (branch) {
                      setState(() {
                        selectedBranch = branch;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            isWide
                ? Row(
              children: [
                Expanded(child: _buildTextField(accountHolderController, 'একাউন্ট হোল্ডার')),
                const SizedBox(width: 3),
                Expanded(child: _buildTextField(accountNumberController, 'একাউন্ট নম্বর')),
                const SizedBox(width: 3),
                Expanded(child: _buildTextField(balanceController, 'বর্তমান ব্যালেন্স', keyboardType: TextInputType.number)),
                const SizedBox(width: 3),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  ),
                  child: const Text('সেভ করুন', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ],
            )
                : Column(
              children: [
                _buildTextField(accountHolderController, 'একাউন্ট হোল্ডার'),
                const SizedBox(height: 10),
                _buildTextField(accountNumberController, 'একাউন্ট নম্বর'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        isDense: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '⚠️ $label প্রয়োজন';
        }
        return null;
      },
    );
  }
}
