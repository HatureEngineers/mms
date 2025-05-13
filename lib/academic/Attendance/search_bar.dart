import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: onSearch,
          decoration: InputDecoration(
            hintText: 'Search by ID or Name',
            hintStyle: const TextStyle(color: Colors.teal),
            prefixIcon: const Icon(Icons.search, color: Colors.black54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ),
    );
  }
}
