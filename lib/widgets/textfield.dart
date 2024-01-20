import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final bool isPass;
  final TextInputType textInputType;
  const TextFieldInput({super.key, required this.hinttext, this.isPass = false, required this.textInputType, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        border: inputBorder ,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
        
      );
  }
}