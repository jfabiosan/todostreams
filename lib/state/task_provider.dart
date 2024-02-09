// task_provider.dart
import 'package:flutter/material.dart';
import '/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _task = [];
  bool _showCompletedTask = false;

  List<Task> get tasks => _task;

  bool get showCompletedTask => _showCompletedTask;

  List<Task> get filteredTask {
    if (_showCompletedTask) {
      return _task;
    } else {
      return _task.where((task) => !task.isCompleted).toList();
    }
  }

  void addTask(Task task) {
    _task.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index, bool newValue) {
    _task[index].isCompleted = newValue;
    notifyListeners();
  }

  void toggleShowCompletedTask(bool value) {
    _showCompletedTask = value;
    notifyListeners();
  }

  void removeTask(int index) {
    _task.removeAt(index);
    notifyListeners();
  }
}
