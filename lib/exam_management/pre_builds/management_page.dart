import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'class_subject_manager.dart';
import 'item_name_list.dart';
import 'subject_average.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final Map<String, List<String>> _items = {
    "শিক্ষাবর্ষ": [],
    "পরীক্ষার নাম": [],
  };

  void _addItem(String category, String item) {
    setState(() {
      _items[category]?.add(item);
    });
  }

  void _editItem(String category, int index, String newItem) {
    setState(() {
      _items[category]?[index] = newItem;
    });
  }

  void _deleteItem(String category, int index) {
    setState(() {
      _items[category]?.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClassSubjectManager(),
            const Divider(),
            const SubjectAverage(),
            const Divider(),
            ItemNameList(
              category: "শিক্ষাবর্ষ",
              items: _items["শিক্ষাবর্ষ"]!,
              onAdd: _addItem,
              onEdit: _editItem,
              onDelete: _deleteItem,
            ),
            const Divider(),
            ItemNameList(
              category: "পরীক্ষার নাম",
              items: _items["পরীক্ষার নাম"]!,
              onAdd: _addItem,
              onEdit: _editItem,
              onDelete: _deleteItem,
            ),
          ],
        ),
      ),
    );
  }
}
