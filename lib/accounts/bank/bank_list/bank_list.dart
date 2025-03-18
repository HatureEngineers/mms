import 'package:flutter/material.dart';

import '../transaction_list/transaction_functions.dart';

class BankList extends StatefulWidget {
  final List<Map<String, String>> bankAccounts;
  const BankList({super.key, required this.bankAccounts});

  @override
  _BankListState createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive Column Count
    int crossAxisCount = screenWidth > 1400
        ? 3
        : screenWidth > 1200
            ? 2
            : 1;

    // Responsive childAspectRatio
    double childAspectRatio = screenWidth > 1400
        ? 1.1
        : screenWidth > 1200
            ? 1.2
            : 1.8;

    return widget.bankAccounts.isEmpty
        ? const Center(
            child: Text(
              'কোনো ব্যাংক একাউন্ট নেই!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          )
        : Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 1200), // বড় স্ক্রিনে কন্টেন্ট সেন্টারে রাখবে
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: widget.bankAccounts.length,
                  itemBuilder: (context, index) {
                    final account = widget.bankAccounts[index];

                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.account_balance,
                                    color: Colors.blue, size: 40),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    account['bankName'] ?? 'অজানা ব্যাংক',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'ব্রাঞ্চ: ${account['branch_name'] ?? 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            Text(
                              'হোল্ডার: ${account['accountHolder'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'একাউন্ট নম্বর: ${account['accountNumber'] ?? 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            Text(
                              'বর্তমান ব্যালেন্স: ${account['balance'] ?? '0'} ৳',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),

                            // ট্রানজেকশন মোড না থাকলে বাটন দেখাবে
                            if (selectedIndex != index)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text('ট্রানজেকশন'),
                                ),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => showTransferDialog(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        foregroundColor: Colors.black,
                                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8), // গোলাকার ভাব কমানো
                                        ),
                                      ),
                                      child: Text(
                                        'ট্রান্সফার',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width > 1400 ? 14 : 11,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => showWithdrawDialog(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[400],
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'উইথড্র',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width > 1400 ? 14 : 11,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => showDepositDialog(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.black,
                                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'ডিপোজিট',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width > 1400 ? 14 : 11,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
