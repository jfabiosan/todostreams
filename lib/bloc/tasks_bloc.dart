// tasks_bloc.dart
import 'dart:async';
import '/repository/tasks_repository.dart';
import '/model/task_model.dart';

class TasksBloc {
  final TasksRepository _tasksRepository = TasksRepository();

  Stream<List<Task>> get tasksStream => _tasksRepository.tasksStream;

  void dispose() {
    _tasksRepository.dispose();
  }

  void addTask(Task task) {
    _tasksRepository.addTask(task);
  }
}
