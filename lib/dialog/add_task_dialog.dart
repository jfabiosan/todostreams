// add_task_dialog.dart
import 'package:flutter/material.dart';
import '/model/task_model.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Tarefa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          Row(
            children: [
              const Text('Clique quando Concluir'),
              Switch(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value;
                  });
                },
              ),
            ],
          ),
        ],
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
              Task newTask = Task(title: title, isCompleted: _isCompleted);
              Navigator.of(context).pop(newTask);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Digite o campo Titulo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ));
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
