// tasks_repository.dart
import 'dart:async';
import '/model/task_model.dart';

class TasksRepository {
  final _tasksController = StreamController<List<Task>>.broadcast();
  final List<Task> _tasks = [];

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  void dispose() {
    _tasksController.close();
  }

  void addTask(Task task) {
    // Verificar se a tarefa já está presente na lista
    if (!_tasks.contains(task)) {
      _tasks.add(task);
      _tasksController.add(_tasks);
    }
  }
}
