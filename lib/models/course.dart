class Course {
  String code;
  String? title;
  int unit;
  String grade;

  Course(
      {required this.code,
      required this.grade,
      this.title,
      required this.unit});

  final Map<String, int> _gradeValue = {
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0
  };
  int get gradeValue {
    return _gradeValue[grade] as int;
  }
}
