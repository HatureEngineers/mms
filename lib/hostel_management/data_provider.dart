class DataProvider {
  static List<String> academicYears = ['2023', '2024', '2025'];

  static Map<String, List<String>> classData = {
    '2023': ['Class 6', 'Class 7'],
    '2024': ['Class 8', 'Class 9'],
    '2025': ['Class 10'],
  };

  static Map<String, List<String>> studentData = {
    'Class 6': ['Alice', 'Bob'],
    'Class 7': ['Charlie', 'David'],
    'Class 8': ['Eve', 'Frank'],
    'Class 9': ['Grace', 'Hank'],
    'Class 10': ['Ivy', 'Jack'],
  };

  // Store guardians for each student
  static Map<String, List<Map<String, String>>> guardiansData = {
    'Alice': [
      {'name': 'John Doe', 'phone': '1234567890', 'relation': 'Father'},
      {'name': 'Jane Doe', 'phone': '0987654321', 'relation': 'Mother'},
    ],
    'Bob': [
      {'name': 'Michael Bob', 'phone': '1122334455', 'relation': 'Father'},
    ],
    'Charlie': [
      {'name': 'David Charlie', 'phone': '2233445566', 'relation': 'Father'},
    ],
    // Add guardians for other students here...
  };

  // Store admission numbers for each student
  static Map<String, String> admissionData = {
    'Alice': '2023-001',
    'Bob': '2023-002',
    'Charlie': '2024-001',
    // Add admission numbers for other students here...
  };

  // নতুন শিক্ষাবর্ষ যোগ করার মেথড
  static void addAcademicYear(String year) {
    if (!academicYears.contains(year)) {
      academicYears.add(year);
      classData[year] = [];
    }
  }

  // নতুন ক্লাস যোগ করার মেথড
  static void addClass(String year, String newClass) {
    if (classData.containsKey(year) && !classData[year]!.contains(newClass)) {
      classData[year]!.add(newClass);
      studentData[newClass] = [];
    }
  }

  // নতুন স্টুডেন্ট যোগ করার মেথড
  static void addStudent(String cls, String student) {
    if (studentData.containsKey(cls) && !studentData[cls]!.contains(student)) {
      studentData[cls]!.add(student);
    }
  }

  // Get admission number for a student
  static String getAdmissionForStudent(String studentName) {
    return admissionData[studentName] ?? 'No Admission Info';
  }

  // Get guardians for a student
  static List<Map<String, String>> getGuardiansForStudent(String studentName) {
    return guardiansData[studentName] ?? [];
  }

  // Add a guardian for a student
  static void addGuardian(String studentName, Map<String, String> guardian) {
    if (guardiansData.containsKey(studentName)) {
      guardiansData[studentName]?.add(guardian);
    } else {
      guardiansData[studentName] = [guardian];
    }
  }
}
