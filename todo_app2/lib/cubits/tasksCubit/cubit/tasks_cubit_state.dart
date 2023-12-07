part of 'tasks_cubit_cubit.dart';

@immutable
sealed class TasksCubitState {}

final class TasksCubitInitial extends TasksCubitState {}

final class AppNavigationBar extends TasksCubitState {}

final class AppCreateDatebaseState extends TasksCubitState {}

final class AppDeleteDatebaseState extends TasksCubitState {}

final class AppGetDatebaseState extends TasksCubitState {}

final class AppGetDatebaseLoadingState extends TasksCubitState {}

final class AppInsertDatebaseState extends TasksCubitState {}

final class AppChangeBottomSheetState extends TasksCubitState {}

final class AppArchiveTasksState extends TasksCubitState {}

final class AppDeleteTasksState extends TasksCubitState {}

final class AppDoneTasksState extends TasksCubitState {}

