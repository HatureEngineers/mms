//RightClickWrapper(child: const ClassName());


import 'package:flutter/material.dart';

class RightClickWrapper extends StatefulWidget {
  final Widget child;

  const RightClickWrapper({super.key, required this.child});

  @override
  _RightClickWrapperState createState() => _RightClickWrapperState();
}

class _RightClickWrapperState extends State<RightClickWrapper> {
  Offset? _tapPosition;

  void _showContextMenu(BuildContext context) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition! & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        const PopupMenuItem(value: 'dashboard', child: Text('🏠 Go to Dashboard')),
        const PopupMenuItem(value: 'settings', child: Text('⚙️ Settings')),
        const PopupMenuItem(value: 'logout', child: Text('🚪 Logout')),
      ],
    );

    if (result == 'dashboard') {
      Navigator.pushNamed(context, '/dashboard');
    } else if (result == 'settings') {
      Navigator.pushNamed(context, '/settings');
    } else if (result == 'logout') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logging out...")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (TapDownDetails details) {
        setState(() {
          _tapPosition = details.globalPosition;
        });
        _showContextMenu(context);
      },
      child: widget.child,
    );
  }
}
