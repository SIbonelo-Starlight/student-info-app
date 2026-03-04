// lib/viewmodels/student_viewmodel.dart
import 'package:flutter/foundation.dart';
import '../models/student_model.dart';

class StudentViewModel extends ChangeNotifier {
  StudentModel _student = StudentModel(
    name: "Sibonelo",
    currentSubject: "TPG316C",
    subjects: ["SOD316C", "TPG316C", "ITS316C"],
    currentIndex: 1,
  );

  // Getters
  String get studentName => _student.name;
  String get currentSubject => _student.currentSubject;
  List<String> get subjects => _student.subjects;
  int get currentIndex => _student.currentIndex;

  // Logic method
  void changeSubject() {
    int newIndex = (_student.currentIndex + 1) % _student.subjects.length;
    _student = _student.copyWith(currentIndex: newIndex);
    notifyListeners();
  }
}
