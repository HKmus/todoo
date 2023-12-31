import 'package:flutter/material.dart';

class AddTaskDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onAdd;
  final VoidCallback onCancel;
  final bool validate;

  const AddTaskDialogBox({
    super.key,
    required this.textController,
    required this.onAdd,
    required this.onCancel,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Add new task',
                border: const OutlineInputBorder(),
                errorText: validate ? null : 'Value Can\'t Be Empty',
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
