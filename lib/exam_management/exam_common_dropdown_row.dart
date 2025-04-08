import 'package:flutter/material.dart';

class CommonDropdownRow<T> extends StatelessWidget {
  final String examLabel;
  final List<T> examItems;
  final T? selectedExam;
  final void Function(T?) onExamChanged;

  final String sessionLabel;
  final List<T> sessionItems;
  final T? selectedSession;
  final void Function(T?) onSessionChanged;

  final String classLabel;
  final List<T> classItems;
  final T? selectedClass;
  final void Function(T?) onClassChanged;

  final String? subjectLabel;
  final List<T>? subjectItems;
  final T? selectedSubject;
  final void Function(T?)? onSubjectChanged;

  const CommonDropdownRow({
    super.key,
    required this.examLabel,
    required this.examItems,
    required this.selectedExam,
    required this.onExamChanged,
    required this.sessionLabel,
    required this.sessionItems,
    required this.selectedSession,
    required this.onSessionChanged,
    required this.classLabel,
    required this.classItems,
    required this.selectedClass,
    required this.onClassChanged,
    this.subjectLabel,
    this.subjectItems,
    this.selectedSubject,
    this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildDropdown(examLabel, examItems, selectedExam, onExamChanged)),
        const SizedBox(width: 10),
        Expanded(child: _buildDropdown(sessionLabel, sessionItems, selectedSession, onSessionChanged)),
        const SizedBox(width: 10),
        Expanded(child: _buildDropdown(classLabel, classItems, selectedClass, onClassChanged)),
        if (subjectItems != null && subjectLabel != null && onSubjectChanged != null)
          ...[
            const SizedBox(width: 10),
            Expanded(child: _buildDropdown(subjectLabel!, subjectItems!, selectedSubject, onSubjectChanged!)),
          ],
      ],
    );
  }

  Widget _buildDropdown(
      String label,
      List<T> items,
      T? value,
      void Function(T?) onChanged,
      ) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        isDense: true,
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
