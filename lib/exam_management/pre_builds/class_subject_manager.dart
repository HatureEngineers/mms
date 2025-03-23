import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassSubjectManager extends StatefulWidget {
  const ClassSubjectManager({super.key});

  @override
  State<ClassSubjectManager> createState() => _ClassSubjectManagerState();
}

class _ClassSubjectManagerState extends State<ClassSubjectManager> {
  final List<String> _classes = []; // ক্লাসের তালিকা
  final Map<String, List<String>> _subjects = {}; // ক্লাস অনুযায়ী বিষয় সংরক্ষণ

  String? _selectedClass;
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _editSubjectController = TextEditingController(); // এডিট করার জন্য কন্ট্রোলার
  final Map<int, DateTime?> _subjectDates = {};
  final Map<int, TimeOfDay?> _subjectTimes = {};
  String? _editingSubject;
  int? _editingIndex;

  // ক্লাস যোগ করার ফাংশন
  void _addClass() {
    String newClass = _classController.text.trim();
    if (newClass.isNotEmpty && !_classes.contains(newClass)) {
      setState(() {
        _classes.add(newClass);  // নতুন ক্লাস যুক্ত
        _subjects[newClass] = []; // নতুন ক্লাসের জন্য খালি বিষয় তালিকা তৈরি
      });
      _classController.clear();
    }
  }

  // বিষয় যোগ করার ফাংশন
  void _addSubject() {
    String newSubject = _subjectController.text.trim();
    if (_selectedClass != null && newSubject.isNotEmpty) {
      setState(() {
        _subjects[_selectedClass!]!.add(newSubject); // নির্বাচিত ক্লাসে নতুন বিষয় যোগ
      });
      _subjectController.clear();
    }
  }

  // বিষয় মুছে ফেলার ফাংশন
  void _deleteSubject(int index) {
    if (_selectedClass != null) {
      setState(() {
        _subjects[_selectedClass!]!.removeAt(index); // নির্বাচিত ক্লাস থেকে বিষয় মুছে ফেলুন
      });
    }
  }

  // বিষয় এডিট করার ফাংশন
  void _editSubject(int index) {
    setState(() {
      _editingSubject = _subjects[_selectedClass!]![index];
      _editingIndex = index;
      _editSubjectController.text = _editingSubject!; // এডিট ফিল্ডে পুরানো বিষয় প্রদর্শন
    });
  }

  // এডিট সংরক্ষণ করার ফাংশন
  void _saveEditedSubject() {
    if (_editingSubject != null && _editingIndex != null) {
      setState(() {
        _subjects[_selectedClass!]![_editingIndex!] = _editSubjectController.text.trim(); // বিষয় আপডেট
        _editingSubject = null;
        _editingIndex = null;
        _editSubjectController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // বাম কলাম (ক্লাস যোগ করার ফিল্ড)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ক্লাস ও বিষয় ব্যবস্থাপনা",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  // ক্লাস যোগ করার UI
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _classController,
                          decoration: InputDecoration(
                            labelText: "নতুন ক্লাস লিখুন",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // কম উচ্চতা
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _addClass,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // কম গোলাকার কোণা
                          ),
                        ),
                        child: const Text("যোগ করুন"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ক্লাস সিলেক্ট করার জন্য ড্রপডাউন
                  DropdownButtonFormField<String>(
                    value: _selectedClass,
                    hint: const Text("একটি ক্লাস নির্বাচন করুন"),
                    items: _classes.map((cls) {
                      return DropdownMenuItem<String>(
                        value: cls,
                        child: Text(cls),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedClass = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // কম উচ্চতা
                      isDense: true, // কমপ্যাক্ট ডিজাইন
                    ),
                  ),

                  const SizedBox(height: 15),

                  // বিষয় যোগ করার UI (শুধুমাত্র যদি ক্লাস সিলেক্ট করা হয়)
                  if (_selectedClass != null) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _subjectController,
                            decoration: InputDecoration(
                              labelText: "নতুন বিষয় লিখুন",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // কম উচ্চতা
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _addSubject,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // কম গোলাকার কোণা
                            ),
                          ),
                          child: const Text("যোগ করুন"),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 20),

            // ডান কলাম (বিষয় তালিকা)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // যদি ক্লাস সিলেক্ট করা থাকে, তাহলে বিষয় তালিকা দেখানো হবে
                  if (_selectedClass != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$_selectedClass এর বিষয় তালিকা",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 15),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, setStateDialog) {
                                      return AlertDialog(
                                        title: const Text(
                                          "ক্লাস ও পরীক্ষার রুটিন তৈরি করুন",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),

                                        content: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10), // Dialog-এর পাশে জায়গা দেওয়া
                                            child: Column(
                                              children: _subjects[_selectedClass!]!.asMap().entries.map((entry) {
                                                int index = entry.key;
                                                String subject = entry.value;

                                                return Container(
                                                  padding: const EdgeInsets.all(10),
                                                  margin: const EdgeInsets.symmetric(vertical: 6), // প্রতিটি আইটেমের মধ্যে gap
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade50, // হালকা নীল ব্যাকগ্রাউন্ড
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.blue.shade100), // বর্ডার
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // নম্বরিং ও বিষয় নাম
                                                      Expanded(
                                                        child: Text(
                                                          "${index + 1}. $subject", // নম্বর সহ বিষয় দেখানো
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                            color: Colors.blueAccent,
                                                          ),
                                                        ),
                                                      ),

                                                      // 📅 তারিখ বাটন এবং তারিখ দেখানো
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(Icons.calendar_month, color: Colors.blue),
                                                            onPressed: () async {
                                                              DateTime? selectedDate = await showDatePicker(
                                                                context: context,
                                                                initialDate: _subjectDates[index] ?? DateTime.now(),
                                                                firstDate: DateTime(2020),
                                                                lastDate: DateTime(2100),
                                                              );
                                                              if (selectedDate != null) {
                                                                setState(() {
                                                                  _subjectDates[index] = selectedDate;
                                                                });
                                                                setStateDialog(() {});
                                                              }
                                                            },
                                                          ),
                                                          Text(
                                                            _subjectDates[index] != null
                                                                ? DateFormat('dd MMM yyyy').format(_subjectDates[index]!)
                                                                : "তারিখ",
                                                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(width: 10), // আইকনগুলোর মধ্যে গ্যাপ

                                                      // ⏰ সময় বাটন এবং সময় দেখানো
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(Icons.access_time, color: Colors.blue),
                                                            onPressed: () async {
                                                              TimeOfDay? selectedTime = await showTimePicker(
                                                                context: context,
                                                                initialTime: _subjectTimes[index] ?? TimeOfDay.now(),
                                                              );
                                                              if (selectedTime != null) {
                                                                setState(() {
                                                                  _subjectTimes[index] = selectedTime;
                                                                });
                                                                setStateDialog(() {});
                                                              }
                                                            },
                                                          ),
                                                          Text(
                                                            _subjectTimes[index]?.format(context) ?? "সময়",
                                                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),

                                        // ✅ বোতামগুলো সেন্টার করা হয়েছে
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10), // নিচের মার্জিন
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center, // বোতামগুলো সেন্টার করা
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    print("Printing class schedule...");
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.teal[800], // ক্লাস রুটিনের জন্য আলাদা রঙ
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10), // কোণা কিছুটা কমানো
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  ),
                                                  child: const Text(
                                                    "ক্লাস রুটিন প্রিন্ট",
                                                    style: TextStyle(color: Colors.white), // টেক্সট সাদা
                                                  ),
                                                ),
                                                const SizedBox(width: 10),

                                                ElevatedButton(
                                                  onPressed: () {
                                                    print("Printing exam schedule...");
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.deepPurple, // পরীক্ষার রুটিনের জন্য আলাদা রঙ
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10), // কোণা কিছুটা কমানো
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  ),
                                                  child: const Text(
                                                    "পরীক্ষার রুটিন প্রিন্ট",
                                                    style: TextStyle(color: Colors.white), // টেক্সট সাদা
                                                  ),
                                                ),
                                                const SizedBox(width: 10),

                                                ElevatedButton(
                                                  onPressed: () => Navigator.of(context).pop(),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red, // বাতিল বোতামের জন্য লাল রঙ
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10), // কোণা কিছুটা কমানো
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  ),
                                                  child: const Text(
                                                    "বাতিল",
                                                    style: TextStyle(color: Colors.white), // টেক্সট সাদা
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.print, color: Colors.white),
                            label: const Text(
                              "রুটিন প্রিন্ট",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // বিষয় তালিকা দেখানো
                    if (_subjects[_selectedClass!]!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _subjects[_selectedClass!]!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: ListTile(
                                  title: Text(
                                    "  ${index + 1}.  ${_subjects[_selectedClass!]![index]}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  trailing: _editingIndex == index
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.save, color: Colors.green),
                                        onPressed: _saveEditedSubject,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.cancel, color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _editingSubject = null;
                                            _editingIndex = null;
                                            _editSubjectController.clear();
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                      : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => _editSubject(index),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteSubject(index),
                                      ),
                                    ],
                                  ),
                                  subtitle: _editingIndex == index
                                      ? Row(
                                    children: [
                                      // তারিখ পিকার
                                      IconButton(
                                        icon: const Icon(Icons.calendar_today, color: Colors.blue),
                                        onPressed: () async {
                                          DateTime? selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (selectedDate != null) {
                                            setState(() {
                                              _subjectDates[index] = selectedDate;
                                            });
                                          }
                                        },
                                      ),
                                      // সময় পিকার
                                      IconButton(
                                        icon: const Icon(Icons.access_time, color: Colors.blue),
                                        onPressed: () async {
                                          TimeOfDay? selectedTime = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (selectedTime != null) {
                                            setState(() {
                                              _subjectTimes[index] = selectedTime;
                                            });
                                          }
                                        },
                                      ),
                                      // প্রদর্শন: তারিখ ও সময়
                                      Text(
                                        "${_subjectDates[index]?.toLocal()} ${_subjectTimes[index]?.format(context)}",
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  )
                                      : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
