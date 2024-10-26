import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextEditingController textController;
  final String? errorText;
  final bool readOnly;
  final TextInputType keyboardType; // New parameter for keyboard type

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textController,
    this.maxLines = 1,
    this.errorText,
    this.readOnly = false,
    this.keyboardType = TextInputType.text, // Default to TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType, // Set the keyboard type here
      decoration: InputDecoration(
        errorText: errorText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
