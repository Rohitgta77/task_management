import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? 'Description is required'
                    : null,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Status'),
                value: _status,
                items: ['Pending', 'In Progress', 'Completed']
                    .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() {
                  _status = value!;
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<TaskProvider>(context, listen: false).addTask(
                      Task(
                        title: _title,
                        description: _description,
                        status: _status,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
