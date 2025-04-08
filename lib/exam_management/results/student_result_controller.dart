// স্টুডেন্ট ক্লাস
class Student {
  final String name;
  final String roll;

  Student({required this.name, required this.roll});
}

class StudentResultController {
  // Dropdown Data
  List<String> exams = ['Mid Term', 'Final'];
  List<String> sessions = ['2023', '2024', '2025'];
  List<String> classes = ['Class 6', 'Class 7', 'Class 8'];

  // Selected Dropdown Values
  String? selectedExam;
  String? selectedSession;
  String? selectedClass;

  // Student Selection
  List<Student> allStudents = [];           // পুরো ক্লাসের ছাত্রদের তালিকা
  List<Student> filteredStudents = [];      // সার্চ রেজাল্ট
  Student? selectedStudent;

  // Dummy Result Data (এখানে API কল করে আসলে লোড করা উচিত)
  List<Map<String, String>> results = [];
  int totalMarks = 0;
  String averageGrade = '';
  String averageGPA = '';

  // Check if all dropdowns are selected to show search field
  bool get canSearchStudents {
    return selectedExam != null && selectedSession != null && selectedClass != null;
  }

  void clearSelectedStudent() {
    selectedStudent = null;
    filteredStudents.clear();
    results.clear();
    totalMarks = 0;
    averageGrade = '';
    averageGPA = '';
  }

  void filterStudents(String query) {
    // কেবল selectedClass অনুযায়ী ছাত্র লোড করি (এখানে আমরা dummy students দিয়ে কাজ করবো)
    if (allStudents.isEmpty) {
      _loadStudentsForSelectedClass();
    }

    filteredStudents = allStudents.where((student) {
      final nameMatch = student.name.toLowerCase().contains(query.toLowerCase());
      final rollMatch = student.roll.toLowerCase().contains(query.toLowerCase());
      return nameMatch || rollMatch;
    }).toList();
  }

  void selectStudent(Student student) {
    selectedStudent = student;

    // যখন student select হবে তখন রেজাল্ট লোড করবো (ডেমো ডেটা)
    _loadResultsForStudent();
  }

  void _loadStudentsForSelectedClass() {
    // এখানে আমরা শুধু ডেমো ছাত্রদের তৈরি করছি
    allStudents = [
      Student(name: 'রহিম উদ্দিন', roll: '101'),
      Student(name: 'করিম খান', roll: '102'),
      Student(name: 'সাব্বির হোসেন', roll: '103'),
    ];
    filteredStudents = allStudents;
  }

  void _loadResultsForStudent() {
    // এই student এর জন্য ডেমো result লোড করছি
    results = [
      {'no': '1', 'subject': 'বাংলা', 'marks': '80', 'grade': 'A', 'gpa': '4.00'},
      {'no': '2', 'subject': 'ইংরেজি', 'marks': '75', 'grade': 'A-', 'gpa': '3.75'},
      {'no': '3', 'subject': 'গণিত', 'marks': '90', 'grade': 'A+', 'gpa': '5.00'},
      {'no': '4', 'subject': 'গণিত', 'marks': '90', 'grade': 'A+', 'gpa': '5.00'},
      {'no': '5', 'subject': 'গণিত', 'marks': '90', 'grade': 'A+', 'gpa': '5.00'},
      {'no': '6', 'subject': 'গণিত', 'marks': '90', 'grade': 'A+', 'gpa': '5.00'},
      {'no': '7', 'subject': 'গণিত', 'marks': '90', 'grade': 'A+', 'gpa': '5.00'},
      {'no': '8', 'subject': 'গণিত', 'marks': '95', 'grade': 'A+', 'gpa': '5.00'},
    ];

    // GPA এর গাণিতিক গড় হিসাব করা হচ্ছে
    double totalGPA = 0.0;
    int count = 0;

    for (var result in results) {
      final gpa = double.tryParse(result['gpa'] ?? '0.0');
      if (gpa != null) {
        totalGPA += gpa;
        count++;
      }
    }

    // মোট নাম্বার ও গ্রেড ক্যালকুলেট
    totalMarks = results.fold(0, (sum, item) => sum + int.tryParse(item['marks'] ?? '0')!);
    averageGrade = 'A';
    averageGPA = count > 0 ? (totalGPA / count).toStringAsFixed(2) : '0.00';
  }
}
