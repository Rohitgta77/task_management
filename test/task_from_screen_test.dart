import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/screens/task_from_screen.dart';

void main() {
  testWidgets('Validates empty form fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(home: TaskFormScreen()),
      ),
    );

    await tester.tap(find.text('Save Task'));
    await tester.pump();

    expect(find.text('Title is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
  });

  testWidgets('Saves a new task when form is valid',
      (WidgetTester tester) async {
    final taskProvider = TaskProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: taskProvider,
        child: const MaterialApp(home: TaskFormScreen()),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'New Task');
    await tester.enterText(find.byType(TextFormField).at(1), 'New Description');
    await tester.tap(find.text('Save Task'));
    await tester.pump();

    expect(taskProvider.tasks.length, 1);
    expect(taskProvider.tasks[0].title, 'New Task');
  });
}
