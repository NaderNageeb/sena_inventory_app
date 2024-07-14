// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CustomeFormFeild extends StatelessWidget {
  String label;
  bool isPasswort = false;
  Widget? prefixIcon;
  Widget? suffixIcon;

  final TextEditingController myController;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  final String? Function(String?) valid;
  final Function onTab;

  CustomeFormFeild({
    super.key,
    required this.label,
    required this.isPasswort,
    this.prefixIcon,
    this.suffixIcon,
    required this.myController,
    this.keyboardType,
    this.textInputAction,
    required this.valid,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTab(),
      validator: valid,
      textInputAction: textInputAction,
      controller: myController,
      obscureText: isPasswort,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        iconColor: Color.fromARGB(255, 11, 65, 118),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(label),
      ),
    );
  }
}
