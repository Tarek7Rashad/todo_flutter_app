import 'package:flutter/material.dart';

List<Map> tasks = [];

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
GlobalKey<FormState> formKey = GlobalKey();
TextEditingController titleTextEditingController = TextEditingController();
TextEditingController timeTextEditingController = TextEditingController();
TextEditingController dateTextEditingController = TextEditingController();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
