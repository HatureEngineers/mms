import 'package:flutter/material.dart';
import '../../widgets/date_button.dart';
import 'admission_form_buttons.dart';
import 'students_address.dart';

class FormFields extends StatefulWidget {
  const FormFields({super.key});

  @override
  _FormFieldsState createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  bool isGorib = false;
  bool isEtim = false;
  bool isProtibondhi = false;
  String? residenceType;

  @override
  void initState() {
    super.initState();
    dateController.text =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  }

  // ✅ চেকবক্স বিল্ডার
  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(fontSize: 14.0)),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading, // বামের দিকে চেকবক্স থাকবে
    );
  }

  // ✅ রেডিও বাটন বিল্ডার
  Widget _buildRadio(String title, String value) {
    return RadioListTile<String>(
      title: Text(title, style: const TextStyle(fontSize: 14.0)),
      value: value,
      groupValue: residenceType,
      onChanged: (val) => setState(() => residenceType = val),
      controlAffinity: ListTileControlAffinity.leading, // বামের দিকে রেডিও বাটন থাকবে
    );
  }

  void _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    ageController.text = age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // প্রথম কলাম
            Expanded(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ভর্তির তারিখ
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ ডান পাশ (ছবি)
                          Expanded(
                            flex: 1, // ডান পাশ ২৫% জায়গা নেবে
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const SizedBox(
                                height: 120, // ফিক্সড উচ্চতা
                                child: Center(
                                  child: Icon(Icons.person, size: 50, color: Colors.blue), // ✅ আপাতত ইমেজ আইকন
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3.0),
                          // ✅ বাম পাশ (ভর্তির তারিখ, ভর্তি ধরন, লিঙ্গ)
                          Expanded(
                            flex: 3, // বাম পাশ ৭৫% জায়গা নেবে
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🔹 ভর্তির তারিখ
                                    TextField(
                                      controller: dateController,
                                      readOnly: true,
                                      style: const TextStyle(fontSize: 14.0, height: 1.0),
                                      decoration: InputDecoration(
                                        labelText: "ভর্তির তারিখ",
                                        labelStyle: const TextStyle(fontSize: 13.0),
                                        filled: true,
                                        fillColor: Colors.blue[50],
                                        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                                        suffixIcon: const Icon(Icons.calendar_month_sharp, color: Colors.blue, size: 20),
                                      ),
                                      onTap: () => showModernDatePicker(context: context, controller: dateController),
                                    ),

                                    const SizedBox(height: 10.0),

                                    // 🔹 ভর্তি ধরন ও লিঙ্গ
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text(
                                                "ধরনঃ ",
                                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 35, // ✅ **উচ্চতা কমানো হয়েছে**
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[50],
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: Colors.blue, width: 1),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      isExpanded: true,
                                                      value: 'নতুন',
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'নতুন',
                                                          child: Text('নতুন', style: TextStyle(color: Colors.black, fontSize: 14)), // ✅ **কালো টেক্সট ও ছোট ফন্ট**
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'পুরাতন',
                                                          child: Text('পুরাতন', style: TextStyle(color: Colors.black, fontSize: 14)),
                                                        ),
                                                      ],
                                                      onChanged: (value) {

                                                      },
                                                      style: const TextStyle(color: Colors.black, fontSize: 11),
                                                      dropdownColor: Colors.blue[50],
                                                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 18), // ✅ **ছোট আইকন**
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 2.0),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text(
                                                "লিঙ্গঃ ",
                                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 35, // ✅ **উচ্চতা কমানো হয়েছে**
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[50],
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: Colors.blue, width: 1),
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      isExpanded: true,
                                                      value: 'ছেলে',
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'ছেলে',
                                                          child: Text('ছেলে', style: TextStyle(color: Colors.black, fontSize: 14)),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'মেয়ে',
                                                          child: Text('মেয়ে', style: TextStyle(color: Colors.black, fontSize: 14)),
                                                        ),
                                                      ],
                                                      onChanged: (value) {

                                                      },
                                                      style: const TextStyle(color: Colors.black, fontSize: 14),
                                                      dropdownColor: Colors.blue[50],
                                                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 18), // ✅ **ছোট আইকন**
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),

                      // নাম ফিল্ড
                      _buildTextField(
                          label: 'দাখেলা', hint: 'দাখেলা লিখুন'),
                      _buildTextField(
                          label: 'নাম', hint: 'শিক্ষার্থীর নাম লিখুন'),
                      _buildTextField(
                          label: 'জন্ম-নিবন্ধন', hint: 'নিবন্ধন নম্বর লিখুন'),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: dobController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 14.0, height: 1.0), // ✅ টেক্সট ছোট করা
                              decoration: InputDecoration(
                                labelText: "জন্ম তারিখ",
                                hintText: "dd-mm-yyyy",
                                labelStyle: const TextStyle(fontSize: 15.0), // ✅ লেবেল ছোট করা
                                isDense: true,
                                filled: true,
                                fillColor: Colors.blue[50],
                                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                suffixIcon: const Icon(Icons.calendar_month_sharp, color: Colors.blue, size: 20),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  dobController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  _calculateAge(pickedDate);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 3.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: ageController,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, height: 2.2), // 🔹 ব্যালেন্স করা উচ্চতা
                              decoration: InputDecoration(
                                isDense: true, // 🔹 ইনপুট ফিল্ড কমপ্যাক্ট থাকবে
                                filled: true,
                                fillColor: Colors.blue[50],
                                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // 🔹 উচ্চতা ব্যালেন্স করা
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                suffixText: "বছর  ",
                                suffixStyle: const TextStyle(fontSize: 14.0, color: Colors.black), // ✅ স্টাইল সুন্দর করা
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 3, // ✅ ই-মেইল ৭৫% জায়গা নেবে
                            child: _buildTextField(label: 'ই-মেইল', hint: 'ই-মেইল ঠিকানা লিখুন'),
                          ),
                          const SizedBox(width: 3.0), // ✅ দুই ফিল্ডের মধ্যে গ্যাপ
                          Expanded(
                            flex: 1, // ✅ রক্তের গ্রুপ ২৫% জায়গা নেবে
                            child: _buildTextField(label: 'রক্তের গ্রুপ', hint: 'A+/B+/O+/AB+'),

                          ),
                        ],
                      ),
                      const SizedBox(height: 3.0),
                      const Text("অসচ্ছল হলেঃ ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(child: _buildCheckbox("এতিম", isEtim, (val) => setState(() => isEtim = val!))),
                          Expanded(child: _buildCheckbox("প্রতিবন্ধী", isProtibondhi, (val) => setState(() => isProtibondhi = val!))),
                          Expanded(child: _buildCheckbox("গরীব", isGorib, (val) => setState(() => isGorib = val!))),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 0.01),

            // দ্বিতীয় কলাম
            Expanded(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // পিতার তথ্য
                      Row(
                        children: [
                          // পিতার নাম (৫০%)
                          Expanded(
                            flex: 1,
                            child: _buildTextField(label: 'পিতার নাম', hint: 'পিতার নাম লিখুন'),
                          ),
                          // পিতার ফোন নম্বর (৫০%)
                          Expanded(
                            flex: 1,
                            child: _buildTextField(label: 'ফোন', hint: 'পিতার ফোন নম্বর লিখুন'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // পিতার NID (৭৫%)
                          Expanded(
                            flex: 2,
                            child: _buildTextField(label: 'NID', hint: 'পিতার NID নম্বর'),
                          ),
                          // পিতার পেশা (২৫%)
                          Expanded(
                            flex: 2,
                            child: _buildTextField(label: 'পেশা', hint: 'পিতার পেশা'),
                          ),
                        ],
                      ),

                      // মাতার তথ্য
                      Row(
                        children: [
                          // মাতার নাম (৫০%)
                          Expanded(
                            flex: 1,
                            child: _buildTextField(label: 'মাতার নাম', hint: 'মাতার নাম লিখুন'),
                          ),
                          // মাতার ফোন নম্বর (৫০%)
                          Expanded(
                            flex: 1,
                            child: _buildTextField(label: 'ফোন', hint: 'মাতার ফোন নম্বর লিখুন'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // মাতার NID (৭৫%)
                          Expanded(
                            flex: 2,
                            child: _buildTextField(label: 'NID', hint: 'মাতার NID নম্বর'),
                          ),
                          // মাতার পেশা (২৫%)
                          Expanded(
                            flex: 2,
                            child: _buildTextField(label: 'পেশা', hint: 'মাতার পেশা'),
                          ),
                        ],
                      ),
                      // অতিরিক্ত ফোন নম্বর (পুরো রো)
                      _buildTextField(label: 'অতিরিক্ত ফোন নম্বর', hint: 'অতিরিক্ত ফোন নম্বর(যদি থাকে)'),

                      // 🔹 আবাসিক, অনাবাসিক, ট্রান্সপোর্ট (সিঙ্গেল সিলেকশন)
                      Row(
                        children: [
                          Expanded(child: _buildRadio("আবাসিক", "আবাসিক")),
                          Expanded(child: _buildRadio("অনাবাসিক", "অনাবাসিক")),
                          // Expanded(child: _buildRadio("ট্রান্সপোর্ট", "ট্রান্সপোর্ট")),
                        ],
                      ),

                      const SizedBox(height: 5.0),

                      // 🔹 আবাসিক হলে অভিভাবকের তথ্য দেখাবে
                      if (residenceType == "আবাসিক") ...[
                        _buildTextField(label: "অভিভাবকের নাম", hint: "অভিভাবকের নাম লিখুন"),
                        _buildTextField(label: "সম্পর্ক", hint: "সম্পর্ক লিখুন"),
                        _buildTextField(label: "ফোন", hint: "অভিভাবকের ফোন নম্বর"),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 0.01),

            // তৃতীয় কলাম (ডানের কলাম)
            Expanded(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddressFormContainer(),

                      SizedBox(height: 5.0),
                      FormButtons(), // ✅ FormButtons ঠিক রাখুন
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 4.0), // 🔹 ফাঁকা কমানো হয়েছে
      child: SizedBox(
        height: 38, // 🔹 সরাসরি উচ্চতা নির্ধারণ (কমপ্যাক্ট ডিজাইন)
        child: TextField(
          style: const TextStyle(
              fontSize: 14.0, height: 1.0), // 🔹 ফন্ট ছোট ও কমপ্যাক্ট
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.blue[50],
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 10.0), // 🔹 ফিল্ডের প্যাডিং কমানো
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
