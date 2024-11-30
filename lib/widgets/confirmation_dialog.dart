import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Dismiss the dialog
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(); // Call the confirmation callback
            Navigator.pop(context); // Dismiss the dialog
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
