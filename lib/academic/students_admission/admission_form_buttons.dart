import 'package:flutter/material.dart';

import '../../widgets/date_button.dart';

class FormButtons extends StatelessWidget {
  const FormButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          globalButton(
            text: "মুছে ফেলুন",
            onPressed: () {
              // মুছে ফেলার লজিক
            },
            bgColor: Colors.redAccent,
            textColor: Colors.white,
            icon: Icons.delete,
          ),
          globalButton(
            text: "ভর্তি করুন",
            onPressed: () {
              // ভর্তি করার লজিক
            },
            bgColor: Colors.green,
            textColor: Colors.white,
            icon: Icons.check_circle,
          ),
        ],
      ),
    );
  }
}
