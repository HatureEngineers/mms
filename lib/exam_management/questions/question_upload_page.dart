import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/scheduler.dart';
import '../../drawer/main_layout_fixedDrawer.dart';
import '../exam_common_dropdown_row.dart';
import 'question_upload_controller.dart';

class QuestionUploadPage extends StatefulWidget {
  const QuestionUploadPage({Key? key}) : super(key: key);

  @override
  State<QuestionUploadPage> createState() => _QuestionUploadPageState();
}

class _QuestionUploadPageState extends State<QuestionUploadPage> {
  final controller = QuestionUploadController();
  final TextEditingController questionController = TextEditingController();
  PlatformFile? selectedFile;

  @override
  void initState() {
    super.initState();
    controller.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SingleChildScrollView(  // Entire page scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdownRow(),
            const SizedBox(height: 20),
            _buildQuestionUploadRow(),
            const SizedBox(height: 20),
            if (controller.selectedSubject != null)
              Text(
                "আপলোড করা প্রশ্ন গুলি:",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10),
            buildUploadedQuestionsGrid(),
          ],
        ),
      ),
    );
  }

  // Dropdown row for selecting Exam, Session, Class, and Subject
  Widget _buildDropdownRow() {
    return CommonDropdownRow<String>(
      examLabel: "পরীক্ষার নাম",
      examItems: controller.exams,
      selectedExam: controller.selectedExam,
      onExamChanged: (value) => setState(() => controller.selectExam(value)),
      sessionLabel: "শিক্ষাবর্ষ",
      sessionItems: controller.sessions,
      selectedSession: controller.selectedSession,
      onSessionChanged: (value) => setState(() => controller.selectSession(value)),
      classLabel: "ক্লাস",
      classItems: controller.availableClasses,
      selectedClass: controller.selectedClass,
      onClassChanged: (value) => setState(() => controller.selectClass(value)),
      subjectLabel: "বিষয়",
      subjectItems: controller.availableSubjects,
      selectedSubject: controller.selectedSubject,
      onSubjectChanged: (value) => setState(() => controller.selectSubject(value)),
    );
  }

  // Question input and upload button
  Widget _buildQuestionUploadRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: questionController,
            decoration: InputDecoration(
              labelText: "বিবরণ লিখুন (ঐচ্ছিক)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // গোলাকার কোণা
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: _pickFile, // Here we are calling the method to pick file
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.upload, color: Colors.white),
          label: const Text("আপলোড করুন",
            style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // বাটনের ব্যাকগ্রাউন্ড রঙ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // কোণার গোলাকৃতি কমিয়ে দেওয়া
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), // আরামদায়ক সাইজ
          ),
          onPressed: controller.selectedExam == null || (questionController.text.isEmpty && selectedFile == null)
              ? null
              : () {
            final questionText = questionController.text.trim();
            if (selectedFile != null) {
              final question = QuestionData(
                exam: controller.selectedExam!,
                year: controller.selectedSession!,
                className: controller.selectedClass!,
                subject: controller.selectedSubject!,
                question: questionText,
                filePath: selectedFile!.path,
              );
              setState(() {
                controller.uploadQuestion(question);
                selectedFile = null;
                questionController.clear();
              });
            }
          },
        ),
      ],
    );
  }

  void _pickFile() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false,
        );

        if (result != null && result.files.isNotEmpty) {
          setState(() {
            selectedFile = result.files.first;
          });
        } else {
          print("No file selected");
        }
      } catch (e) {
        print("Error picking file: $e");
      }
    });
  }

  Future<String> getWindowsDownloadFolder() async {
    final userProfile = Platform.environment['USERPROFILE'];
    if (userProfile != null) {
      return path.join(userProfile, 'Downloads');
    }
    throw Exception("Couldn't locate Downloads folder");
  }

  Widget _buildFilePreview(String? filePath) {
    if (filePath == null) {
      return const Icon(Icons.insert_drive_file, size: 90, color: Colors.grey);
    }

    final extension = filePath.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png', 'gif'].contains(extension);

    if (isImage) {
      return Image.file(
        File(filePath),
        height: 90,
        width: 90,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 90, color: Colors.red);
        },
      );
    } else if (extension == 'pdf') {
      return const Icon(Icons.picture_as_pdf, size: 90, color: Colors.redAccent);
    } else {
      return const Icon(Icons.insert_drive_file, size: 90, color: Colors.grey);
    }
  }

  // Display uploaded questions in grid format
  Widget buildUploadedQuestionsGrid() {
    if (controller.uploadedQuestions.isEmpty) {
      return const Center(
        child: Text(
          "এখনও কোনো প্রশ্ন আপলোড করা হয়নি।",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: controller.uploadedQuestions.length,
      itemBuilder: (context, index) {
        final question = controller.uploadedQuestions[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _buildFilePreview(question.filePath),
                  ),
                ),
                const SizedBox(height: 10),
                Text("পরীক্ষা: ${question.exam}", style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("শিক্ষাবর্ষ: ${question.year}", style: TextStyle(color: Colors.grey[900])),
                Text("ক্লাস: ${question.className}", style: TextStyle(color: Colors.grey[900])),
                Text("বিষয়: ${question.subject}", style: TextStyle(color: Colors.grey[900])),
                Text("বিবরণ: ${question.question}", style: TextStyle(color: Colors.grey[900])),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download_rounded, color: Colors.indigo),
                        onPressed: () async {
                          if (question.filePath == null) return;

                          try {
                            final downloadDir = await getWindowsDownloadFolder();
                            final fileName = path.basename(question.filePath!);
                            final newPath = path.join(downloadDir, fileName);

                            await File(question.filePath!).copy(newPath);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("✅ ফাইল ডাউনলোড হয়েছে: $newPath")),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("❌ ডাউনলোডে সমস্যা হয়েছে: $e")),
                            );
                          }
                        }
                    ),
                    IconButton(
                      icon: const Icon(Icons.print_rounded, color: Colors.teal),
                      onPressed: () {
                        print('Print clicked for ${question.exam}');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          controller.deleteQuestion(question);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
