// task_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/dialog/confirm_del_dialog.dart';
import '/state/task_provider.dart';
import '/dialog/help_dialog.dart';
import '/dialog/add_task_dialog.dart';
import '/model/task_model.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

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
          Consumer<TaskProvider>(
            builder: (context, provider, child) => Switch(
              value: provider.showCompletedTask,
              onChanged: (value) {
                provider.toggleShowCompletedTask(value);
              },
            ),
          )
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          List<Task> task = provider.filteredTask;
          return task.isEmpty
              ? const Center(
                  child: Card(
                    margin: EdgeInsets.all(40),
                    child: Text(
                      'Clique no botão + para inserir a primeira tarefa.',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(task[index].title),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmDelDialog(
                              onDeleteConfirmed: () {
                                provider.removeTask(index);
                              },
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        provider.removeTask(index);
                      },
                      child: TaskItem(
                        task: task[index],
                        onToggle: (bool newValue) {
                          provider.toggleTaskCompletion(index, newValue);
                        },
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialog();
            },
          );
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
    return Card(
      child: ListTile(
        title: Text(task.title),
        trailing: Switch(
          value: task.isCompleted,
          onChanged: onToggle,
        ),
      ),
    );
  }
}
