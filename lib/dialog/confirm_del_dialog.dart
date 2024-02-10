// confirm_del_dialog.dart
import 'package:flutter/material.dart';

class ConfirmDelDialog extends StatelessWidget {
  final VoidCallback onDeleteConfirmed;

  const ConfirmDelDialog({Key? key, required this.onDeleteConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: const Text('Tem certeza de que deseja excluir esta tarefa?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onDeleteConfirmed(); // Chamar a função de exclusão
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('Excluir'),
        ),
      ],
    );
  }
}
