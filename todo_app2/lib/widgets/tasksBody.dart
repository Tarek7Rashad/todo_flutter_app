// ignore: file_names
import 'package:flutter/material.dart';
import 'package:todo_app2/cubits/tasksCubit/cubit/tasks_cubit_cubit.dart';

Widget buildTaskItem(Map tasksMap, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black87,
          radius: 40,
          child: Text(
            '${tasksMap['time']}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tasksMap['title']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${tasksMap['date']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(12),
              onChanged: (value) {
                if (value == 'archive') {
                  TasksCubitCubit.get(context).updateTask(
                    status: 'archive',
                    id: tasksMap['id'],
                  );
                  debugPrint(tasksMap['status']);
                } else if (value == 'done') {
                  TasksCubitCubit.get(context).doneTask(
                    status: 'done',
                    id: tasksMap['id'],
                  );
                } else if (value == 'delete') {
                  TasksCubitCubit.get(context).deleteTask(
                    id: tasksMap['id'],
                  );
                }
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'archive',
                  child: Row(
                    children: [
                      Icon(Icons.archive),
                      SizedBox(width: 10),
                      Text('Archive'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'done',
                  child: Row(
                    children: [
                      Icon(Icons.check_box),
                      SizedBox(width: 10),
                      Text('Done'),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
