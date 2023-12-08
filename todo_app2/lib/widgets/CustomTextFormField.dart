import 'package:flutter/material.dart';
import 'package:todo_app2/shared/constant.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintTxt,
    required this.labelTxt,
    this.inputType = TextInputType.text,
    required this.controller,
    this.ontap,
    this.validator,
    this.onsub,
  });
  final String hintTxt;
  final String labelTxt;
  final TextInputType inputType;
  final TextEditingController controller;
  final VoidCallback? ontap;

  final String? Function(String?)? validator;
  final String? Function(String?)? onsub;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
      onTap: ontap,
      validator: validator,
      keyboardType: inputType,
      onFieldSubmitted: onsub,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintTxt,
          labelText: labelTxt,
          labelStyle:
              TextStyle(fontSize: 20, color: kWhiteColor.withOpacity(.9)),
          hintStyle:
              TextStyle(fontSize: 20, color: kWhiteColor.withOpacity(.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0.3,
              color: kWhiteColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: kBlackColor.withOpacity(.7),
            ),
          )),
    );
  }
}
