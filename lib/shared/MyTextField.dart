import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool isPassword;
  final TextInputType type;
  final String hintText;
  final Icon icon;
  final TextEditingController? controller;

  const MyTextField({
    Key? key,
    required this.isPassword,
    required this.type,
    required this.hintText,
    required this.icon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFF0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFFAEADAD),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
    );
  }
}
