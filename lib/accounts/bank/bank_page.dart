import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'add_new_bank/bank_form.dart';
import 'bank_list/bank_list.dart';
import 'transaction_list/transaction_list.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  List<Map<String, String>> bankAccounts = [];
  bool showBankForm = false; // এটি BankForm এর দৃশ্যমানতা নিয়ন্ত্রণ করবে

  void addBankAccount(Map<String, String> account) {
    setState(() {
      bankAccounts.add(account);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          // বাটনের ওপরে ফাঁকা জায়গা
          const SizedBox(height: 10.0), // বাটনের ওপরে ফাঁকা জায়গা

          // বাটন যোগ করা
          ElevatedButton(
            onPressed: () {
              setState(() {
                showBankForm = !showBankForm; // টগল করে BankForm দেখানো বা লুকানো
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(showBankForm ? 'ফর্ম হাইড করুন' : 'নতুন ব্যাংক একাউন্ট যোগ করুন'),
          ),

          // বাটনের নিচে ফাঁকা জায়গা
          const SizedBox(height: 5.0), // বাটনের নিচে ফাঁকা জায়গা

          // BankForm টগল করা
          if (showBankForm) BankForm(onSave: addBankAccount),

          // ব্যাংক একাউন্টের তালিকা
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 5, // 50% জায়গা নেবে BankList
                  child: BankList(bankAccounts: bankAccounts),
                ),
                Container(
                  width: 1, // ডিভাইডারের প্রস্থ (পুরুত্ব)
                  color: Colors.blue, // হালকা ধূসর রঙের বিভাজক
                  margin: const EdgeInsets.symmetric(vertical: 0), // উপরে-নিচে ফাঁকা রাখবে
                ),
                Expanded(
                  flex: 5, // 50% জায়গা নেবে TransactionList
                  child: TransactionList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
