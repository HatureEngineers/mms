class QuestionUploadController {
  // Dropdown values
  List<String> exams = ["১ম সাময়িক", "বার্ষিক"];
  List<String> sessions = ["২০২৩", "২০২৪"];
  Map<String, List<String>> classBySession = {
    "২০২৩": ["৬ষ্ঠ", "৭ম"],
    "২০২৪": ["৮ম", "৯ম"]
  };
  Map<String, List<String>> subjectsByClass = {
    "৬ষ্ঠ": ["গণিত", "বাংলা"],
    "৭ম": ["গণিত", "ইংরেজি"],
    "৮ম": ["বিজ্ঞান", "বাংলা"],
    "৯ম": ["রসায়ন", "জীববিজ্ঞান"],
  };

  // Selected values
  String? selectedExam;
  String? selectedSession;
  String? selectedClass;
  String? selectedSubject;

  // Uploaded questions list
  List<QuestionData> uploadedQuestions = [];

  // Dropdown dependencies
  List<String> get availableClasses =>
      selectedSession != null ? classBySession[selectedSession!] ?? [] : [];
  List<String> get availableSubjects =>
      selectedClass != null ? subjectsByClass[selectedClass!] ?? [] : [];

  void loadInitialData() {
    // Optional: API call
  }

  void selectExam(String? exam) {
    selectedExam = exam;
    // Clear previously selected values when exam changes
    selectedSession = null;
    selectedClass = null;
    selectedSubject = null;
  }

  void selectSession(String? session) {
    selectedSession = session;
    selectedClass = null;
    selectedSubject = null;
  }

  void selectClass(String? klass) {
    selectedClass = klass;
    selectedSubject = null;
  }

  void selectSubject(String? subject) {
    selectedSubject = subject;
  }

  void uploadQuestion(QuestionData question) {
    uploadedQuestions.add(question);
  }

  void deleteQuestion(QuestionData question) {
    uploadedQuestions.remove(question);
  }
}

class QuestionData {
  final String exam;
  final String year;
  final String className;
  final String subject;
  final String question;
  final String? filePath;

  QuestionData({
    required this.exam,
    required this.year,
    required this.className,
    required this.subject,
    required this.question,
    this.filePath,
  });
}
