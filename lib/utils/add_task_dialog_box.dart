import 'package:flutter/material.dart';

class AddTaskDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const AddTaskDialogBox({
    super.key,
    required this.textController,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Add new task',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onAdd,
                  child: const SizedBox(
                    width: 50,
                    child: Center(
                      child: Text('Add'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onCancel,
                  child: const SizedBox(
                    width: 50,
                    child: Center(
                      child: Text('Cancel'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
