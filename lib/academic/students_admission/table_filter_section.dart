import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final String selectedFilter;
  final TextEditingController searchController;
  final List<String> filters;
  final List<String> academicYears;
  final List<String> classes;
  final String? selectedYear;
  final String? selectedClass;
  final Function(String) onFilterChanged;
  final Function(String) onYearChanged;
  final Function(String) onClassChanged;
  final Function(String) onSearch;

  const FilterSection({
    super.key,
    required this.title,
    required this.selectedFilter,
    required this.searchController,
    required this.filters,
    required this.academicYears,
    required this.classes,
    required this.selectedYear,
    required this.selectedClass,
    required this.onFilterChanged,
    required this.onYearChanged,
    required this.onClassChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, // এখানে 'ভর্তি করা শিক্ষার্থীর তালিকা' বা অন্য কিছু পাঠানো যাবে
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: selectedFilter,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 14.0,
                  ),
                  underline: const SizedBox(), // Remove default underline
                  items: filters.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    onFilterChanged(newValue!);
                  },
                ),
              ),
              const SizedBox(width: 10),
              if (selectedFilter == 'শিক্ষাবর্ষ' || selectedFilter == 'সকল')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedYear,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 14.0,
                    ),
                    underline: const SizedBox(), // Remove default underline
                    items: academicYears.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      onYearChanged(value!);
                    },
                  ),
                ),
              if (selectedFilter == 'ক্লাস' || selectedFilter == 'সকল')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedClass,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 14.0,
                    ),
                    underline: const SizedBox(), // Remove default underline
                    items: classes.map((cls) {
                      return DropdownMenuItem(
                        value: cls,
                        child: Text(cls),
                      );
                    }).toList(),
                    onChanged: (value) {
                      onClassChanged(value!);
                    },
                  ),
                ),
              if (selectedFilter != 'সকল' &&
                  selectedFilter != 'শিক্ষাবর্ষ' &&
                  selectedFilter != 'ক্লাস')
                Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) => onSearch(query),
                    decoration: InputDecoration(
                      hintText: '$selectedFilter অনুসন্ধান করুন',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: InputBorder.none, // Remove default border
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}