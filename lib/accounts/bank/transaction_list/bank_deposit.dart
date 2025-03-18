import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../../widgets/date_button.dart';
import '../bank_dropdown.dart';
import '../branch_dropdown.dart';

// Declare all the controllers and variables inside the dialog function
TextEditingController dateController = TextEditingController();
TextEditingController accountHolderController = TextEditingController();
TextEditingController accountNumberController = TextEditingController();
TextEditingController depositorNameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController amountController = TextEditingController();
String? selectedBank;
String? selectedBranch;


// ডিপোজিট ফর্ম পপআপ
void showDepositDialog(BuildContext context) {

  DateTime selectedDate = DateTime.now();
  dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            "ব্যাংক ডিপোজিট করুন",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // লেনদেনের তারিখ (Date Picker)
              Row(
                children: [
                  // লেনদেনের তারিখ
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14.0, height: 1.0),
                      decoration: InputDecoration(
                        labelText: "লেনদেনের তারিখ",
                        hintText: "dd-mm-yyyy",
                        labelStyle: const TextStyle(fontSize: 13.0),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.blue[50],
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        suffixIcon: const Icon(Icons.calendar_month_sharp, color: Colors.blue, size: 20),
                      ),
                      onTap: () => showModernDatePicker(context: context, controller: dateController),
                    ),
                  ),
                  SizedBox(width: 10),

                  // ব্যাংক নির্বাচন
                  Expanded(
                    child: BankDropdown(
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: 10),

                  // ব্রাঞ্চ নির্বাচন
                  Expanded(
                    child: BranchDropdown(
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  // একাউন্ট হোল্ডারের নাম
                  Expanded(
                    child: SizedBox(
                      height: 40, // উচ্চতা নির্দিষ্ট করে দেওয়া হয়েছে
                      child: TextField(
                        controller: accountHolderController,
                        decoration: InputDecoration(
                          labelText: "একাউন্ট হোল্ডারের নাম",
                          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.blueAccent, size: 18),
                          filled: true,
                          fillColor: Colors.blue[50],
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),

                  // একাউন্ট নম্বর (শুধু সংখ্যা ইনপুট)
                  Expanded(
                    child: SizedBox(
                      height: 40, // উচ্চতা নির্দিষ্ট করে দেওয়া হয়েছে
                      child: TextField(
                        controller: accountNumberController,
                        decoration: InputDecoration(
                          labelText: "একাউন্ট নম্বর",
                          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.numbers, color: Colors.blueAccent, size: 18),
                          filled: true,
                          fillColor: Colors.blue[50],
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              SizedBox(
                height: 42, // নির্দিষ্ট উচ্চতা
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: "ডিপোজিট পরিমাণ (টাকা)",
                    labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // কম গোলাকৃতি
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.green, size: 18), // ছোট আইকন
                    filled: true,
                    fillColor: Colors.blue[50],
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // উচ্চতা কমানো
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(height: 10), // গ্যাপ কমানো

              Row(
                children: [
                  // বিবরণ (মাল্টি-লাইন) - ৫০% জায়গা
                  Flexible(
                    flex: 1,  // ৫০% জায়গা নেবে
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "বিবরণ",
                        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // কম গোলাকৃতি
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      ),
                      maxLines: 3,  // মাল্টি-লাইন
                    ),
                  ),
                  SizedBox(width: 10),  // ইনপুট ফিল্ডগুলোর মাঝে গ্যাপ

                  // কলাম যেখানে লেনদেনকারীর নাম এবং বাটন থাকবে - ৫০% জায়গা
                  Flexible(
                    flex: 1,  // ৫০% জায়গা নেবে
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // কলামের ভিতরের এলাইনমেন্ট
                      children: [
                        SizedBox(height: 10),
                        // লেনদেনকারীর নাম
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: depositorNameController,
                            decoration: InputDecoration(
                              labelText: "জমা-কারীর নাম",
                              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),  // বাটনগুলোর মাঝে গ্যাপ

                        // বাটন দুটি
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,  // বাটনগুলো ডানদিকে
                          children: [
                            // "বাতিল" বাটন
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red, // টেক্সটের রঙ
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // প্যাডিং
                                shape: RoundedRectangleBorder(  // বাটনের কোণগুলি গোলাকৃত
                                  borderRadius: BorderRadius.circular(8), // কোণ গোলাকার হওয়া কমানো হয়েছে
                                ),
                                side: BorderSide(color: Colors.red, width: 2), // বর্ডারের রঙ ও সাইজ
                              ),
                              child: const Text(
                                "বাতিল",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(width: 10),  // বাটনগুলোর মাঝে গ্যাপ

                            // "সাবমিট" বাটন
                            ElevatedButton(
                              onPressed: () {
                                submitDeposit(context);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent, // ব্যাকগ্রাউন্ড কালার
                                foregroundColor: Colors.white, // টেক্সটের রঙ
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // প্যাডিং
                                shape: RoundedRectangleBorder(  // বাটনের কোণগুলি গোলাকৃত
                                  borderRadius: BorderRadius.circular(8), // কোণ গোলাকার হওয়া কমানো হয়েছে
                                ),
                              ),
                              child: const Text(
                                "সাবমিট",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


void submitDeposit(BuildContext context) async {
  final depositData = {
    "account_holder": accountHolderController.text,
    "account_number": accountNumberController.text,
    "depositor_name": depositorNameController.text,
    "description": descriptionController.text,
    "amount": amountController.text,
    "bank_name": selectedBank,
    "branch_name": selectedBranch,
    "transaction_date": dateController.text,
  };

  try {
    final response = await http.post(
      Uri.parse("http://localhost:3000/bank-deposit/add"), // আপনার API URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(depositData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ডিপোজিট সফলভাবে যোগ হয়েছে")),
      );
      Navigator.of(context).pop(); // ডায়লগ বন্ধ করা
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ডিপোজিট সংরক্ষণে ব্যর্থ হয়েছে")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("সার্ভারের সাথে সংযোগ করা যাচ্ছে না")),
    );
  }
}
