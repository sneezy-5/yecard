import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextEditingController textController;
  final String? errorText;
  final bool readOnly;


  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textController,
    this.maxLines = 1,
    this.errorText,
    this.readOnly =false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      readOnly: readOnly,
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
    //     if (errorText != null) ...[
    // SizedBox(height: 5),
    // Text(
    // errorText!,
    // style: TextStyle(color: Colors.red, fontSize: 12),
    // ),
    // ],
    );
  }
}
