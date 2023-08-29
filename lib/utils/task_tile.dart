import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String task;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        child: Row(
          children: [
            Checkbox(value: isCompleted, onChanged: onChanged),
            Expanded(
              child: Text(
                task,
                style: TextStyle(
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_forever),
              color: Colors.red[700],
            )
          ],
        ),
      ),
    );
  }
}
