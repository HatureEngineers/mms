class SeatPlanController {
  List<String> exams = ["১ম সাময়িক", "বার্ষিক"];
  List<String> sessions = ["২০২৩", "২০২৪"];
  Map<String, List<String>> classBySession = {
    "২০২৩": ["৬ষ্ঠ", "৭ম"],
    "২০২৪": ["৮ম", "৯ম"]
  };

  String? selectedExam;
  String? selectedSession;
  String? selectedClass;

  List<String> get availableClasses =>
      selectedSession != null ? classBySession[selectedSession!] ?? [] : [];

  List<Student> students = [];

  void loadInitialData() {}

  void selectExam(String? exam) {
    selectedExam = exam;
    selectedSession = null;
    selectedClass = null;
  }

  void selectSession(String? session) {
    selectedSession = session;
    selectedClass = null;
  }

  void selectClass(String? klass) {
    selectedClass = klass;
  }

  int remainingStudents(Map<String, int> dist) {
    final total = 30;
    final assigned = dist.values.fold(0, (sum, val) => sum + val);
    return total - assigned;
  }
}

class Student {
  final String name;
  final int roll;

  Student({required this.name, required this.roll});
}

class RoomData {
  final String? session;
  final String? klass;
  final String room;
  final int count;

  RoomData({
    required this.session,
    required this.klass,
    required this.room,
    required this.count,
  });
}
