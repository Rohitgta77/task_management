import 'package:flutter_test/flutter_test.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/task_provider.dart';

void main() {
  group('TaskProvider Tests', () {
    test('Add Task', () {
      final taskProvider = TaskProvider();

      final task = Task(
          title: 'Test Task', description: 'Description', status: 'Pending');
      taskProvider.addTask(task);

      expect(taskProvider.tasks.length, 1);
      expect(taskProvider.tasks[0].title, 'Test Task');
    });

    test('Update Task', () {
      final taskProvider = TaskProvider();

      final task = Task(
          title: 'Test Task', description: 'Description', status: 'Pending');
      taskProvider.addTask(task);

      final updatedTask = Task(
          title: 'Updated Task',
          description: 'Updated Description',
          status: 'Completed');
      taskProvider.updateTask(0, updatedTask);

      expect(taskProvider.tasks[0].title, 'Updated Task');
      expect(taskProvider.tasks[0].status, 'Completed');
    });

    test('Delete Task', () {
      final taskProvider = TaskProvider();

      final task = Task(
          title: 'Test Task', description: 'Description', status: 'Pending');
      taskProvider.addTask(task);

      taskProvider.deleteTask(0);

      expect(taskProvider.tasks.isEmpty, true);
    });
  });
}
