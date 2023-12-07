import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required IconData prefixIcon,
  required String label,
  String hintText = "Enter Your Email",
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  Function? validate,
  Function? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate!(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(suffix)),
        border: OutlineInputBorder(),
      ),
      onTap: () {
        onTap!();
      },
    );
