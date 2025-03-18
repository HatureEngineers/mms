import 'package:flutter/material.dart';

Future<DateTime?> showModernDatePicker({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  DateTime? pickedDate;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.blue, width: 2)),
            content: SizedBox(
              width: 300, // ডায়ালগের প্রস্থ ফিক্সড
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // সিলেক্টেড তারিখ দেখানোর জন্য টেক্সট
                  if (pickedDate != null)
                    Text(
                      "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // সেন্টারে দেখানো
                    ),
                  const SizedBox(height: 16.0),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateChanged: (date) {
                      setState(() {
                        pickedDate = date; // সিলেক্টেড তারিখ আপডেট
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('বাতিল'),
              ),
              TextButton(
                onPressed: () {
                  if (pickedDate != null) {
                    controller.text =
                    "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                  }
                  Navigator.pop(context);
                },
                child: const Text('ঠিক আছে'),
              ),
            ],
          );
        },
      );
    },
  );

  // সিলেক্টেড তারিখ রিটার্ন করা
  return pickedDate;
}

Widget globalButton({
  required String text,
  required VoidCallback onPressed,
  Color bgColor = Colors.blue,
  Color textColor = Colors.white,
  IconData? icon,
  double padding = 14.0,
  double fontSize = 16.0,
  double borderRadius = 10.0,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: textColor,
      padding: EdgeInsets.symmetric(horizontal: padding * 1.5, vertical: padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 5.0,
      shadowColor: Colors.black45,
    ),
    icon: icon != null ? Icon(icon, size: fontSize + 2) : const SizedBox.shrink(),
    label: Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    ),
  );
}
