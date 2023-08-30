import 'package:flutter/material.dart';
import 'package:todoo/data/database.dart';
import 'package:todoo/utils/add_task_dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoo/utils/task_tile.dart';

class TaskDashboard extends StatefulWidget {
  const TaskDashboard({super.key, required this.title});

  final String title;

  @override
  State<TaskDashboard> createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  //reference the hive box
  final Box _myBox = Hive.box('TBox');

  TodoDB db = TodoDB();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final TextEditingController _controller = TextEditingController();
  bool _validate = true;

  void addTask() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        _validate = false;
        Navigator.of(context).pop();
        _creatTask();
      } else {
        _validate = true;
        db.tasks.add([_controller.text.trim(), false]);
        _controller.clear();
        Navigator.of(context).pop();
        db.updateDataBase();
      }
    });
  }

  void _creatTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialogBox(
          textController: _controller,
          onAdd: addTask,
          validate: _validate,
          onCancel: () {
            _validate = true;
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
    });
    db.updateDataBase();
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
                                  db.tasks = [];
                                });
                                db.updateDataBase();
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
        child: db.tasks.isNotEmpty
            ? ListView.builder(
                itemCount: db.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskTile(
                    task: db.tasks[index][0],
                    isCompleted: db.tasks[index][1],
                    onChanged: (value) =>
                        checkBoxChanged(db.tasks[index][1], index),
                    onDelete: () {
                      setState(() {
                        db.tasks.removeAt(index);
                      });
                      db.updateDataBase();
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
