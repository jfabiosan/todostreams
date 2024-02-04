// tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:todostreams/dialog/help_dialog.dart';
import '/bloc/tasks_bloc.dart';
import '/dialog/add_task_dialog.dart';
import '/model/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TasksBloc _tasksBloc = TasksBloc();
  bool showCompletedTasks = true;

  @override
  void dispose() {
    _tasksBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const HelpDialog(),
              );
            },
            icon: const Icon(Icons.help),
          ),
          Switch(
            value: showCompletedTasks,
            onChanged: (value) {
              setState(() {
                showCompletedTasks = value;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: _tasksBloc.tasksStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Card(
                margin: EdgeInsets.all(40),
                child: Text(
                  'Clique no botão + para inserir a primeira tarefa.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          List<Task> tasks = snapshot.data!;
          List<Task> filteredTasks = showCompletedTasks
              ? tasks
              : tasks.where((task) => !task.isCompleted).toList();

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                task: filteredTasks[index],
                onToggle: (bool newValue) {
                  setState(() {
                    filteredTasks[index].isCompleted = newValue;
                  });
                  _tasksBloc.addTask(filteredTasks[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskDialog();
            },
          );

          if (newTask != null) {
            _tasksBloc.addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onToggle;

  const TaskItem({Key? key, required this.task, required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Switch(
        value: task.isCompleted,
        onChanged: onToggle,
      ),
    );
  }
}
