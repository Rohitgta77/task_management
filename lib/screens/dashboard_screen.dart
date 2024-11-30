import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/screens/task_from_screen.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management Dashboard'),
      ),
      body: taskProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks available. Add some!'))
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(taskIndex: index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          );
        },
      ),
    );
  }
}
