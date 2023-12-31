// ignore: file_names
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_app2/cubits/tasksCubit/cubit/tasks_cubit_cubit.dart';
import 'package:todo_app2/shared/constant.dart';

Widget buildTaskItem(Map tasksMap, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card(
      color: Colors.blueGrey,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 40,
              child: Text(
                '${tasksMap['time']}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kGreyColor),
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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${tasksMap['date']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                      AwesomeDialog(
                        btnCancelColor: Colors.blueGrey,
                        dismissOnBackKeyPress: true,
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        desc: 'Do You Want To Archive This Task?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          TasksCubitCubit.get(context).updateTask(
                            status: 'archive',
                            id: tasksMap['id'],
                          );
                          debugPrint(tasksMap['status']);
                        },
                      ).show();
                    } else if (value == 'done') {
                      AwesomeDialog(
                        btnCancelColor: Colors.blueGrey,
                        dismissOnBackKeyPress: true,
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        desc: 'Do You Want Add This Task To Done Tasks?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          TasksCubitCubit.get(context).doneTask(
                            status: 'done',
                            id: tasksMap['id'],
                          );
                        },
                      ).show();
                    } else if (value == 'delete') {
                      AwesomeDialog(
                        btnCancelColor: Colors.blueGrey,
                        dismissOnBackKeyPress: true,
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        desc: 'Do You Want To Delete This Task?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          TasksCubitCubit.get(context).deleteTask(
                            id: tasksMap['id'],
                          );
                        },
                      ).show();
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
      ),
    ),
  );
}
