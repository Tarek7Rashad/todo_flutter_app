import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app2/Modules/archived_tasks.dart';
import 'package:todo_app2/Modules/done_tasks.dart';
import 'package:todo_app2/Modules/new_tasks.dart';

part 'tasks_cubit_state.dart';

class TasksCubitCubit extends Cubit<TasksCubitState> {
  TasksCubitCubit() : super(TasksCubitInitial());
  static TasksCubitCubit get(context) => BlocProvider.of(context);

  late Database database111;
  List<Map> tasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  IconData editIcon = Icons.edit;
  late bool isShow;
  bool isButtonSheet = false;
  int currrentIndex = 0;
  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];
  List<String> titles = ["NEW TASKS", "DONE TASKS", "ARCHIVE TASKS"];
  void changeIndex(int value) {
    currrentIndex = value;
    emit(AppNavigationBar());
  }

  Future<void> createDatabase() async {
    emit(AppCreateDatebaseState());
    log('Database10 Created');
    database111 = await openDatabase(
      "todo.db", //path
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE Tasks111(id INTEGER PRIMARY KEY ,title TEXT,date TEXT ,time TEXT ,status TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((onError) {
          debugPrint('error when table created is ${onError.toString()}');
        });
      }, // onCreate
      onOpen: (db) {
        debugPrint('Database Opened');
      },
    ).then((value) {
      emit(AppCreateDatebaseState());
      return database111 = value;
    });
    getDataFromDataBase1(database111).then((value) {
      tasks = value;

      // log(tasks.toString());
      emit(AppGetDatebaseState());
    }).catchError((error) {
      log('error here ${error.toString()}');
    });
  }

  Future<void> insertDatabase(
      {required title, required date, required time}) async {
    return await database111.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO Tasks111 (title,date,time,status) VALUES ("$title","$date","$time","now")')
          .then((value) {
        debugPrint('$value Inserted Succesfully');
        emit(AppInsertDatebaseState());
        getDataFromDataBase1(database111).then((value) {
          // tasks = value;

          // log(tasks.toString());
          emit(AppGetDatebaseState());
          emit(AppArchiveTasksState());
          emit(AppDoneTasksState());
          emit(AppDeleteTasksState());
        });
      }).catchError((onError) {
        debugPrint('Error Occured When Inserting New Raw : $onError');
      });
    });
  }

  Future<void> deleteDatabase(String path) {
    emit(AppDeleteDatebaseState());
    log("deleted");
    return databaseFactory.deleteDatabase(path);
  }

  Future<List<Map>> getDataFromDataBase1(Database database) async {
    // ignore: unnecessary_null_comparison
    if (database111 == null) {
      return Future.error('Database is not initialized');
    }
    tasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(AppGetDatebaseLoadingState());
    List<Map<String, dynamic>> tasksList =
        await database111.rawQuery("SELECT * FROM Tasks111");

    for (var task in tasksList) {
      String status = task['status'];
      if (status == 'done') {
        doneTasks.add(task);
        emit(AppDoneTasksState());
        emit(AppGetDatebaseState());
      } else if (status == 'archive') {
        archiveTasks.add(task);
        emit(AppArchiveTasksState());
        emit(AppGetDatebaseState());
      } else {
        tasks.add(task);
        emit(AppGetDatebaseState());
      }
    }

    return tasks;
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    emit(AppChangeBottomSheetState());
    isButtonSheet = isShow;
    editIcon = icon;
  }

  void updateTask({required String status, required int id}) async {
    await database111.rawUpdate("UPDATE Tasks111 SET status = ? WHERE id = ? ",
        [status, id]).then((value) {
      getDataFromDataBase1(database111).then(
        (value) {
          tasks = value;
          emit(AppArchiveTasksState());
          emit(AppGetDatebaseState());
        },
      );
    });
  }

  void doneTask({required String status, required int id}) async {
    await database111.rawUpdate("UPDATE Tasks111 SET status = ? WHERE id = ? ",
        [status, id]).then((value) {
      getDataFromDataBase1(database111).then(
        (value) {
          tasks = value;
          emit(AppDoneTasksState());
          emit(AppGetDatebaseState());
        },
      );
    });
  }

  void deleteTask({required int id}) {
    database111
        .rawDelete("DELETE FROM Tasks111 WHERE id = ? ", [id]).then((value) {
      getDataFromDataBase1(database111).then((value) {
        tasks = value;
        emit(AppGetDatebaseState());
      });
      emit(AppDeleteDatebaseState());
    });
  }

  Future<void> deleteTasksTable() async {
    try {
      await database111.execute("DROP TABLE IF EXISTS Tasks10");
      log('Table "Tasks10" deleted');
    } catch (error) {
      log('Error when deleting table: ${error.toString()}');
    }
  }
}
