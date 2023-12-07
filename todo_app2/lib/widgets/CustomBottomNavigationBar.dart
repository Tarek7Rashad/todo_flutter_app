import 'package:flutter/material.dart';
import 'package:todo_app2/cubits/tasksCubit/cubit/tasks_cubit_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.cubit,
  });

  final TasksCubitCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: cubit.currrentIndex,
      onTap: (value) {
        cubit.changeIndex(value);
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconSize: 30,
      selectedLabelStyle: const TextStyle(fontSize: 20),
      unselectedFontSize: 15,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.new_label_outlined),
          label: "New",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline), label: "Done"),
        BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined), label: "Archive"),
      ],
    );
  }
}
