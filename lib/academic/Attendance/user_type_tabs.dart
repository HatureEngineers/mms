import 'package:flutter/material.dart';

class UserTypeTabs extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const UserTypeTabs({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text('শিক্ষার্থী'),
          selected: selected == 'student',
          onSelected: (_) => onSelect('student'),
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text('শিক্ষক/স্টাফ'),
          selected: selected == 'staff',
          onSelected: (_) => onSelect('staff'),
        ),
      ],
    );
  }
}
