import 'package:flutter/material.dart';

class ItemNameList extends StatefulWidget {
  final String category;
  final List<String> items;
  final Function(String, String) onAdd;
  final Function(String, int, String) onEdit;
  final Function(String, int) onDelete;

  const ItemNameList({
    super.key,
    required this.category,
    required this.items,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<ItemNameList> createState() => _ItemNameListState();
}

class _ItemNameListState extends State<ItemNameList> {
  final TextEditingController _controller = TextEditingController();
  int? _editingIndex;
  final TextEditingController _editController = TextEditingController();

  void _handleAdd() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onAdd(widget.category, _controller.text.trim());
      _controller.clear();
    }
  }

  void _handleEdit(int index) {
    setState(() {
      _editingIndex = index;
      _editController.text = widget.items[index];
    });
  }

  void _handleSaveEdit() {
    if (_editController.text.trim().isNotEmpty && _editingIndex != null) {
      widget.onEdit(widget.category, _editingIndex!, _editController.text.trim());
      setState(() => _editingIndex = null);
    }
  }

  void _handleDelete(int index) {
    widget.onDelete(widget.category, index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.category} যোগ করুন",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            const SizedBox(height: 8),

            Row(
              children: [
                // ✅ বাম পাশে ইনপুট ফিল্ড + অ্যাড বাটন
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: "লিখুন",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), // হালকা গোলাকার কোণা
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // উচ্চতা কমানো
                            isDense: true, // ইনপুট ফিল্ড কম্প্যাক্ট করা
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _handleAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // সবুজ রঙ
                          foregroundColor: Colors.white, // সাদা টেক্সট
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // কম উচ্চতার বাটন
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // হালকা গোলাকার কোণা
                          ),
                        ),
                        child: const Text("যোগ করুন", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // ✅ ডান পাশে লিস্ট
                Expanded(
                  flex: 2,
                  child: Column(
                    children: widget.items.asMap().entries.map((entry) {
                      int index = entry.key;
                      String item = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8), // মার্জিন দিয়ে সুন্দর করা
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // হালকা গোলাকার ডিজাইন
                        ),
                        elevation: 2, // হালকা শ্যাডো
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                "${index + 1}. ", // সিরিয়াল নম্বর দেখানো (1. 2. 3.)
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: _editingIndex == index
                                    ? TextField(
                                  controller: _editController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8), // গোলাকার ডিজাইন
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    isDense: true, // কমপ্যাক্ট ডিজাইন
                                  ),
                                )
                                    : Text(
                                  item,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          trailing: _editingIndex == index
                              ? IconButton(
                            icon: const Icon(Icons.save, color: Colors.green),
                            onPressed: _handleSaveEdit,
                          )
                              : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _handleEdit(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _handleDelete(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
