import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app2/cubits/tasksCubit/cubit/tasks_cubit_cubit.dart';
import 'package:todo_app2/shared/constant.dart';
import 'package:todo_app2/widgets/CustomBottomNavigationBar.dart';
import 'package:todo_app2/widgets/CustomTextFormField.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // String? input;
  static const String id = "HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubitCubit()..createDatabase(),
      child: BlocConsumer<TasksCubitCubit, TasksCubitState>(
        listener: (context, state) {
          if (state is AppInsertDatebaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          TasksCubitCubit cubit = TasksCubitCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    shape: const CircleBorder(
                        side: BorderSide(
                      width: 3,
                      color: Colors.black,
                    )),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    onPressed: () {
                      if (cubit.isButtonSheet) {
                        if (formKey.currentState!.validate()) {
                          cubit.insertDatabase(
                            title: titleTextEditingController.text,
                            date: dateTextEditingController.text,
                            time: timeTextEditingController.text,
                          );
                          autovalidateMode = AutovalidateMode.always;
                        }
                      } else {
                        autovalidateMode = AutovalidateMode.disabled;
                        scaffoldKey.currentState!
                            .showBottomSheet(
                              shape: const ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(80),
                                      topRight: Radius.circular(80))),
                              backgroundColor: kGreyColor.withOpacity(.9),
                              (context) {
                                return Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  key: formKey,
                                  child: SizedBox(
                                    height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                              onsub: (input) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (titleTextEditingController
                                                      .text.isNotEmpty) {}
                                                }
                                                return null;
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Title Is Required Field";
                                                }
                                                return null;
                                              },
                                              controller:
                                                  titleTextEditingController,
                                              inputType: TextInputType.text,
                                              hintTxt: "task title",
                                              labelTxt: "Task Title"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomTextFormField(
                                              onsub: (input) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (timeTextEditingController
                                                      .text.isNotEmpty) {}
                                                }
                                                return null;
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Time Is Required Field";
                                                }
                                                return null;
                                              },
                                              ontap: () {
                                                showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now())
                                                    .then((value) {
                                                  if (value != null) {
                                                    timeTextEditingController
                                                            .text =
                                                        value
                                                            .format(context)
                                                            .toString();
                                                  }
                                                });
                                              },
                                              controller:
                                                  timeTextEditingController,
                                              inputType: TextInputType.datetime,
                                              hintTxt: "time",
                                              labelTxt: "Time"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomTextFormField(
                                              onsub: (input) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if (dateTextEditingController
                                                      .text.isNotEmpty) {
                                                  } else {
                                                    return null;
                                                  }
                                                }
                                                return null;
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Date Is Required Field";
                                                }
                                                return null;
                                              },
                                              ontap: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime.parse(
                                                      "2027-05-13"),
                                                ).then(
                                                  (value) {
                                                    if (value != null) {
                                                      dateTextEditingController
                                                              .text =
                                                          DateFormat.yMMMd()
                                                              .format(value);
                                                    }
                                                  },
                                                );
                                              },
                                              controller:
                                                  dateTextEditingController,
                                              inputType: TextInputType.datetime,
                                              hintTxt: "date",
                                              labelTxt: "Date"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                            .closed
                            .then((value) {
                              // Navigator.pop(context);

                              cubit.isButtonSheet = false;
                              titleTextEditingController.clear();
                              timeTextEditingController.clear();
                              dateTextEditingController.clear();

                              cubit.changeBottomSheetState(
                                  isShow: cubit.isButtonSheet,
                                  icon: Icons.edit);
                            });
                        cubit.isButtonSheet = true;

                        cubit.changeBottomSheetState(
                            isShow: cubit.isButtonSheet, icon: Icons.add);
                      }
                    },
                    child: Icon(cubit.editIcon),
                  ),
                ],
              ),
              bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black87),
                backgroundColor: kGreyColor.withOpacity(.7),
                elevation: 0,
                actions: [
                  IconButton(
                      iconSize: 28,
                      onPressed: () {},
                      icon: const Icon(Icons.search))
                ],
                title: Text(
                  cubit.titles[cubit.currrentIndex],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatebaseLoadingState,
                builder: (context) => cubit.screens[cubit.currrentIndex],
                fallback: (context) => Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.withOpacity(.3),
                    ),
                    child: SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: Colors.black,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
