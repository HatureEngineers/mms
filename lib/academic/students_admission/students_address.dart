import 'package:flutter/material.dart';

import '../../widgets/bd_address.dart';

// ঠিকানা ইনপুট ফর্ম
class AddressForm extends StatefulWidget {
  final bool isPermanent;
  final bool isCurrentAddressEnabled;
  final Function(String division, String district, String thana,
      String postOffice, String village, String house) onChanged;
  final String? initialDivision;
  final String? initialDistrict;
  final String? initialThana;
  final String? initialPostOffice;
  final String? initialVillage;
  final String? initialHouse;

  const AddressForm({
    super.key,
    required this.isPermanent,
    required this.isCurrentAddressEnabled,
    required this.onChanged,
    this.initialDivision,
    this.initialDistrict,
    this.initialThana,
    this.initialPostOffice,
    this.initialVillage,
    this.initialHouse,
  });

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  String? selectedDivision;
  String? selectedDistrict;
  String? selectedThana;
  String postOffice = "";
  String village = "";
  String house = "";

  @override
  void initState() {
    super.initState();
    selectedDivision = divisions.contains(widget.initialDivision)
        ? widget.initialDivision
        : null;
    selectedDistrict = selectedDivision != null &&
        districts[selectedDivision]!.keys.contains(widget.initialDistrict)
        ? widget.initialDistrict
        : null;
    selectedThana = selectedDistrict != null &&
        districts[selectedDivision]![selectedDistrict]!
            .contains(widget.initialThana)
        ? widget.initialThana
        : null;

    postOffice = widget.initialPostOffice ?? "";
    village = widget.initialVillage ?? "";
    house = widget.initialHouse ?? "";
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableDistricts = selectedDivision != null
        ? districts[selectedDivision]!.keys.toList()
        : [];
    List<String> availableThanas =
    (selectedDistrict != null && selectedDivision != null)
        ? districts[selectedDivision]![selectedDistrict]!
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.isPermanent ? "স্থায়ী ঠিকানা" : "বর্তমান ঠিকানা",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

        const SizedBox(height: 10),

        // বিভাগ ও জেলা
        Row(
          children: [
            Expanded(
              child:
              _buildDropdown("বিভাগ", selectedDivision, divisions, (value) {
                setState(() {
                  selectedDivision = value;
                  selectedDistrict = null;
                  selectedThana = null;
                });
                widget.onChanged(
                    selectedDivision ?? "", "", "", postOffice, village, house);
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDropdown(
                  "জেলা", selectedDistrict, availableDistricts, (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedThana = null;
                });
                widget.onChanged(selectedDivision ?? "", selectedDistrict ?? "",
                    "", postOffice, village, house);
              }),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // থানা ও ডাকঘর
        Row(
          children: [
            Expanded(
              child: _buildDropdown("থানা", selectedThana, availableThanas,
                      (value) {
                    setState(() {
                      selectedThana = value;
                    });
                    widget.onChanged(selectedDivision ?? "", selectedDistrict ?? "",
                        selectedThana ?? "", postOffice, village, house);
                  }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextField("ডাকঘর", postOffice, (value) {
                setState(() {
                  postOffice = value;
                });
                widget.onChanged(selectedDivision ?? "", selectedDistrict ?? "",
                    selectedThana ?? "", postOffice, village, house);
              }),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // গ্রাম ও বাড়ি
        Row(
          children: [
            Expanded(
              child: _buildTextField("গ্রাম", village, (value) {
                setState(() {
                  village = value;
                });
                widget.onChanged(selectedDivision ?? "", selectedDistrict ?? "",
                    selectedThana ?? "", postOffice, village, house);
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextField("বাড়ি", house, (value) {
                setState(() {
                  house = value;
                });
                widget.onChanged(selectedDivision ?? "", selectedDistrict ?? "",
                    selectedThana ?? "", postOffice, village, house);
              }),
            ),
          ],
        ),
      ],
    );
  }

  // ড্রপডাউন বিল্ডার ফাংশন
  Widget _buildDropdown(String label, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return SizedBox(
      height: 38, // ✅ উচ্চতা নির্দিষ্ট করে দেওয়া হয়েছে
      child: DropdownButtonFormField<String>(
        isDense: true, // ✅ কম উচ্চতার জন্য
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.blue[50], // ✅ ব্যাকগ্রাউন্ড কালার
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 8), // ✅ কম padding
        ),
        value: items.contains(value) ? value : null,
        style: const TextStyle(
            fontSize: 14,
            color: Colors.black), // ✅ **ড্রপডাউন সিলেক্টেড টেক্সট কালো**
        iconSize: 20, // ✅ ছোট আইকন
        dropdownColor: Colors.blue[50], // ✅ ড্রপডাউন তালিকার ব্যাকগ্রাউন্ড
        elevation: 2,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black)), // ✅ **ড্রপডাউন অপশনের কালো টেক্সট**
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // টেক্সটফিল্ড বিল্ডার ফাংশন
  Widget _buildTextField(
      String label, String value, ValueChanged<String> onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 10), // উচ্চতা আরও কমানো
        isDense: true,
      ),
      initialValue: value,
      enabled: widget.isCurrentAddressEnabled,
      onChanged: onChanged,
    );
  }
}

class AddressFormContainer extends StatefulWidget {
  const AddressFormContainer({super.key});

  @override
  _AddressFormContainerState createState() => _AddressFormContainerState();
}

// ঠিকানা ফর্ম ব্যবহারের জন্য UI
class _AddressFormContainerState extends State<AddressFormContainer> {
  String permanentDivision = "",
      permanentDistrict = "",
      permanentThana = "",
      permanentPostOffice = "",
      permanentVillage = "",
      permanentHouse = "";
  String currentDivision = "",
      currentDistrict = "",
      currentThana = "",
      currentPostOffice = "",
      currentVillage = "",
      currentHouse = "";

  bool isSameAddress = false;

  void copyPermanentToCurrent() {
    setState(() {
      if (isSameAddress) {
        currentDivision = permanentDivision;
        currentDistrict = permanentDistrict;
        currentThana = permanentThana;
        currentPostOffice = permanentPostOffice;
        currentVillage = permanentVillage;
        currentHouse = permanentHouse;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressForm(
          isPermanent: true,
          isCurrentAddressEnabled: true,
          onChanged: (division, district, thana, postOffice, village, house) {
            setState(() {
              permanentDivision = division;
              permanentDistrict = district;
              permanentThana = thana;
              permanentPostOffice = postOffice;
              permanentVillage = village;
              permanentHouse = house;
            });
          },
        ),
        const SizedBox(height: 10),
        // "একই" বাটন
        ElevatedButton(
          onPressed: () {
            setState(() {
              isSameAddress = !isSameAddress;
              copyPermanentToCurrent(); // কপি করার জন্য ফাংশন কল
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isSameAddress ? Colors.green[100] : Colors.blue[100],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            isSameAddress ? "একই ঠিকানা" : "ভিন্ন ঠিকানা",
            style: const TextStyle(fontSize: 14),
          ),
        ),

        AddressForm(
          key: Key(isSameAddress
              ? "current_address_disabled"
              : "current_address_enabled"),
          isPermanent: false,
          isCurrentAddressEnabled: !isSameAddress, // "একই" হলে ফিল্ড লক হবে
          onChanged: (division, district, thana, postOffice, village, house) {
            setState(() {
              if (!isSameAddress) {
                currentDivision = division;
                currentDistrict = district;
                currentThana = thana;
                currentPostOffice = postOffice;
                currentVillage = village;
                currentHouse = house;
              }
            });
          },
          initialDivision: isSameAddress ? permanentDivision : null,
          initialDistrict: isSameAddress ? permanentDistrict : null,
          initialThana: isSameAddress ? permanentThana : null,
          initialPostOffice: isSameAddress ? permanentPostOffice : null,
          initialVillage: isSameAddress ? permanentVillage : null,
          initialHouse: isSameAddress ? permanentHouse : null,
        ),
      ],
    );
  }
}
