import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'confirmation_dialog.dart';

class TaskItem extends StatelessWidget {
  final int taskIndex;

  const TaskItem({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final task = taskProvider.tasks[taskIndex];

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: DropdownButton(
          value: task.status,
          items: ['Pending', 'In Progress', 'Completed']
              .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
              .toList(),
          onChanged: (newStatus) {
            taskProvider.updateTask(
              taskIndex,
              Task(
                title: task.title,
                description: task.description,
                status: newStatus!,
              ),
            );
          },
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => ConfirmationDialog(
              title: 'Delete Task',
              content: 'Are you sure you want to delete this task?',
              onConfirm: () {
                taskProvider.deleteTask(taskIndex);
              },
            ),
          );
          taskProvider.deleteTask(taskIndex);
        },
      ),
    );
  }
}
