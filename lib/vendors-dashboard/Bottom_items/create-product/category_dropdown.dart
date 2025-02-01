import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final List<String> subCategories;
  final ValueChanged<String?> onCategoryChanged;

  CategoryDropdown({
    required this.selectedCategory,
    required this.subCategories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedCategory,
          items: subCategories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: onCategoryChanged,
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
          dropdownColor: Colors.white,
        ),
      ],
    );
  }
}
