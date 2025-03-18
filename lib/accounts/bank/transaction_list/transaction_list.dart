import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Map<String, dynamic>> transactions = [];
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/bank-deposit/all'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          transactions = data.map((item) => {
            "type": "ডিপোজিট",  // আপাতত সব ট্রানজেকশনকে "ডিপোজিট" ধরছি, API থেকে আলাদা করলে ঠিক করুন
            "date": DateTime.parse(item["transaction_date"]),
            "account": item["account_number"],
            "bank": item["bank_name"],
            "branch": item["branch_name"],
            "depositor": item["depositor_name"],
            "amount": item["amount"],
            "description": item["description"]
          }).toList();
        });
      } else {
        throw Exception("ডাটা লোড করতে ব্যর্থ হয়েছে");
      }
    } catch (error) {
      setState(() {
      });
    }
  }

  Color getTransactionColor(String type) {
    switch (type) {
      case "ডিপোজিট":
        return Colors.green;
      case "উইথড্র":
        return Colors.red[400]!;
      case "ট্রান্সফার":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showContextMenu(BuildContext context, Map<String, dynamic> transaction, int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition! & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        const PopupMenuItem(value: 'edit', child: Text('✏️ Edit Transaction')),
        const PopupMenuItem(value: 'delete', child: Text('🗑️ Delete Transaction')),
      ],
    );

    if (result == 'edit') {
      _editTransaction(index);
    } else if (result == 'delete') {
      _deleteTransaction(index);
    }
  }

  void _editTransaction(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Editing transaction: ${transactions[index]["account"]}")),
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Transaction deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "লেনদেন তালিকা",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blueAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return GestureDetector(
              onSecondaryTapDown: (TapDownDetails details) {
                setState(() {
                  _tapPosition = details.globalPosition;
                });
                _showContextMenu(context, transaction, index);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: Icon(
                    Icons.monetization_on,
                    color: getTransactionColor(transaction["type"]!),
                    size: 30,
                  ),
                  title: Text(
                    "${transaction["type"]} [${DateFormat('dd, MMM yyyy - hh:mm a').format(transaction["date"])}]",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("অ্যাকাউন্ট: ${transaction["account"]}"),
                      Text("ব্যাংক: ${transaction["bank"]}${transaction["branch"] != null ? " - ${transaction["branch"]}" : ""}"),
                      if (transaction["description"] != null)
                        Text("বিবরণ: ${transaction["description"]}"),
                      if (transaction["depositor"] != null)
                        Text("জমাকারী: ${transaction["depositor"]}"),
                    ],
                  ),
                  trailing: Text(
                    "৳${transaction["amount"]} ",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
