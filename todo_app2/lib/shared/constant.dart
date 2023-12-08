import 'package:flutter/material.dart';

const kBlackColor = Colors.black87;
const kBlueGreyColor = Colors.blueGrey;
const kGreyColor = Colors.grey;
const kWhiteColor = Colors.white;

List<Map> tasks = [];

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
GlobalKey<FormState> formKey = GlobalKey();
TextEditingController titleTextEditingController = TextEditingController();
TextEditingController timeTextEditingController = TextEditingController();
TextEditingController dateTextEditingController = TextEditingController();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
