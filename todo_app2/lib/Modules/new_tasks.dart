import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app2/cubits/tasksCubit/cubit/tasks_cubit_cubit.dart';
import 'package:todo_app2/widgets/tasksBody.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubitCubit, TasksCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TasksCubitCubit.get(context).tasks;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 2,
                color: Colors.grey,
              );
            },
            itemBuilder: (context, index) {
              return buildTaskItem(tasks[index],context);
            },
            itemCount: tasks.length);
      },
    );
  }
}
