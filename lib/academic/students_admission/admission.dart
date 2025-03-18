import 'package:flutter/material.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import 'admission_form_fields.dart';
import 'admission_list.dart';

class Admission extends StatelessWidget {
  const Admission({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ✅ এটি দিয়ে Column-এর height ঠিক করা হয়েছে
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue[50],
                padding: const EdgeInsets.all(1.0),
                child: const FormFields(),
              ),
              Container(
                color: Colors.blue[50],
                height: 800,
                padding: const EdgeInsets.all(1.0),
                child: const AdmissionList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
