import 'package:flutter/material.dart';

class ProductInputField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextEditingController controller; // Add this line

  ProductInputField({
    required this.label,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    required this.controller, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextFormField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          controller: controller, // Add this line
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
            ),
          ),
          cursorColor: Colors.purple,
        ),
      ],
    );
  }
}
