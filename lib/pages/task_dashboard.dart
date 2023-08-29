import 'package:flutter/material.dart';
import 'package:todoo/utils/add_task_dialog_box.dart';
import 'package:todoo/utils/task_tile.dart';

class TaskDashboard extends StatefulWidget {
  const TaskDashboard({super.key, required this.title});

  final String title;

  @override
  State<TaskDashboard> createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  final TextEditingController _controller = TextEditingController();

  List<List> task = [];

  void addTask() {
    setState(() {
      task.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void _creatTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialogBox(
          textController: _controller,
          onAdd: addTask,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      task[index][1] = !task[index][1];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.grey[200],
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      surfaceTintColor: Colors.white,
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Delete all tasks',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red[100], // Background color
                              ),
                              onPressed: () {
                                setState(() {
                                  task = [];
                                });
                              },
                              child: SizedBox(
                                child: Center(
                                  child: Text(
                                    'yes, Delete',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.more_vert,
                size: 30,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: task.isNotEmpty
            ? ListView.builder(
                itemCount: task.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskTile(
                    task: task[index][0],
                    isCompleted: task[index][1],
                    onChanged: (value) =>
                        checkBoxChanged(task[index][1], index),
                    onDelete: () {
                      setState(() {
                        task.removeAt(index);
                      });
                    },
                  );
                },
              )
            : const Center(
                child: Text(
                  'task List is empty',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _creatTask,
        tooltip: 'Add new',
        child: const Icon(Icons.add),
      ),
    );
  }
}
