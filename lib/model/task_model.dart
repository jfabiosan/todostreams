// task_model.dart
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  void toggleTaskStatus(Task task) {}
}
