import 'package:flutter/material.dart';
import '/model/task_model.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  AddTaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                if (title.isNotEmpty) {
                  Task newTask = Task(title: title);
                  Navigator.of(context).pop(newTask);
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
        ),
      ),
    );
  }
}
