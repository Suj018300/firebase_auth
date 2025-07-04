import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    super.key, 
    required this.textEditingController, 
    this.isPass = false, 
    required this.hintText, 
    required this.textInputType
  });

  @override
  Widget build(BuildContext context) {
    final borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      // gapPadding: 10,
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        // labelText: 'Label text',
        hintText: hintText,
        // errorText: 'Error message',
        border: borderDecoration,
        focusedBorder: borderDecoration,
        enabledBorder: borderDecoration,
        // suffixIcon: Icon(
        //   Icons.error,
        // ),
        contentPadding: EdgeInsets.all(8),
        filled: true
      ),
      keyboardType: textInputType,
      obscureText: isPass,
  );
  }
}