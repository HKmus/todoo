import 'package:flutter/material.dart';
import 'package:todoo/task_ticket.dart';
//import 'package:todoo/task_ticket.dart';

class TaskDashboard extends StatelessWidget {
  const TaskDashboard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return const TaskTicket();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new',
        child: const Icon(Icons.add),
      ),
    );
  }
}
