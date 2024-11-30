import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/screens/dashboard_screen.dart';

void main() {
  testWidgets('Displays "No tasks available" when task list is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    expect(find.text('No tasks available. Add some!'), findsOneWidget);
  });

  testWidgets('Displays tasks in the task list', (WidgetTester tester) async {
    final taskProvider = TaskProvider();
    taskProvider.addTask(
        Task(title: 'Task 1', description: 'Description', status: 'Pending'));

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: taskProvider,
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
  });
}
