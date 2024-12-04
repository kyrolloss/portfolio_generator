import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final VoidCallback? onChange;
  final VoidCallback? onEditingComplete;


  const MyTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText, this.onChange, this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (_){
        onChange!();
      },
      onEditingComplete: onEditingComplete,
      controller: textEditingController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.5),

          borderSide:
              const BorderSide(color: Colors.red, width: 1.5), // لون التركيز هنا
        ),
        hintText: hintText,
      ),
    );
  }
}
















