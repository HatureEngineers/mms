class Student {
  final String id;
  final String name;
  int? marks;

  Student({required this.id, required this.name, this.marks});
}

class SubjectResultController {
  // Dummy dropdown data
  final List<String> exams = ["Exam 1", "Exam 2", "Exam 3"];
  final List<String> sessions = ["Session 1", "Session 2"];
  final List<String> classes = ["Class 1", "Class 2", "Class 3"];
  final List<String> subjects = ["Math", "Science", "English"];

  // Default students used for initializing new result list
  final List<Student> defaultStudents = [
    Student(id: "101", name: "Student A"),
    Student(id: "102", name: "Student B"),
    Student(id: "103", name: "Student C"),
  ];

  // Dropdown selections
  String? selectedExam;
  String? selectedSession;
  String? selectedClass;
  String? selectedSubject;

  // Currently loaded students based on selected dropdowns
  List<Student> students = [];

  // Active student selected for editing marks
  Student? selectedStudentForMarks;

  // Stores all results: uniqueKey => List<Student>
  final Map<String, List<Student>> resultMap = {};

  // Generate a unique key from current selections
  String getCurrentKey() {
    return "${selectedExam ?? ''}_${selectedSession ?? ''}_${selectedClass ?? ''}_${selectedSubject ?? ''}";
  }

  void selectExam(String? value) {
    selectedExam = value;
    selectedSession = null;
    selectedClass = null;
    selectedSubject = null;
    students = [];
    selectedStudentForMarks = null;
  }

  void selectSession(String? value) {
    selectedSession = value;
    selectedClass = null;
    selectedSubject = null;
    students = [];
    selectedStudentForMarks = null;
  }

  void selectClass(String? value) {
    selectedClass = value;
    selectedSubject = null;
    students = [];
    selectedStudentForMarks = null;
  }

  void selectSubject(String? value) {
    selectedSubject = value;
    _loadOrInitializeStudents(); // subject select হলে student লোড বা ইনিশিয়ালাইজ
  }

  void _loadOrInitializeStudents() {
    final key = getCurrentKey();
    if (!resultMap.containsKey(key)) {
      // নতুন কপি তৈরি করুন defaultStudents থেকে
      resultMap[key] = defaultStudents
          .map((s) => Student(id: s.id, name: s.name))
          .toList();
    }
    students = resultMap[key]!;
    selectFirstStudent();
  }

  void selectStudentForMarks(Student student) {
    selectedStudentForMarks = student;
  }

  void updateMarksForStudent(Student student) {
    final index = students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      students[index] = student;
    }
  }

  void selectFirstStudent() {
    if (students.isNotEmpty) {
      selectedStudentForMarks = students.first;
    } else {
      selectedStudentForMarks = null;
    }
  }

  void moveToNextStudent() {
    final currentIndex = students.indexOf(selectedStudentForMarks!);
    if (currentIndex + 1 < students.length) {
      selectedStudentForMarks = students[currentIndex + 1];
    } else {
      selectedStudentForMarks =  students[0];
    }
  }
}
