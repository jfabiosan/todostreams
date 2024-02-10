import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/state/task_provider.dart';
import '/model/task_model.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  AddTaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: TextField(
        controller: _titleController,
        decoration: const InputDecoration(labelText: 'Título'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            String title = _titleController.text;
            if (title.isNotEmpty) {
              Task newTask = Task(title: title);
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(newTask);
              Navigator.of(context)
                  .pop(); // Feche o diálogo após adicionar a tarefa
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Digite o campo Título",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
