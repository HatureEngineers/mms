import 'package:flutter/material.dart';
import 'drawer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 1000;

    return Scaffold(
      appBar: isLargeScreen ? null : AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: isLargeScreen ? null : const AppDrawer(),
      body: Row(
        children: [
          if (isLargeScreen)
            const SizedBox(
              width: 250,
              child: AppDrawer(),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
