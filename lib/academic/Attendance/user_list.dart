import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'student_attendance_page.dart';

class UserList extends StatefulWidget {
  final String type;
  final String searchText;

  const UserList({super.key, required this.type, required this.searchText});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void didUpdateWidget(covariant UserList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      getUsers(); // ট্যাব পরিবর্তন হলে নতুন করে ডেটা লোড করো
    }
  }

  Future<void> getUsers() async {
    final result = await Process.run(
      'C:\\Python313\\python.exe',
      ['C:\\zk_integration\\zk_attendance.py', 'users'],
    );

    if (result.exitCode == 0) {
      try {
        final data = jsonDecode(result.stdout);

        final filtered = data.where((user) {
          if (widget.type == 'student') {
            return user['user_id'].toString().startsWith('1');
          } else if (widget.type == 'staff') {
            return user['user_id'].toString().startsWith('2');
          }
          return false;
        }).toList();

        setState(() {
          users = filtered;
        });
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    } else {
      print("Script error: ${result.stderr}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((u) {
      final userId = u['user_id'].toString();
      final name = u['name'].toString();
      return userId.contains(widget.searchText) || name.contains(widget.searchText);
    }).toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: user['image'] != null
                ? Image.network(user['image'], width: 50, height: 50, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 50),
          ),
          title: Text("ID: ${user['user_id']}, Name: ${user['name'] ?? 'Not Available'}"),
          subtitle: Text("Class: 5"), //kon class kas id match kore sob student er admission theke asbe, Teacher/Staff hoile designation ba Teacher/Staff rakha jay
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StudentProfilePage(
                  userId: user['user_id'].toString(),
                  userName: user['name'] ?? '',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
