import 'package:flutter/material.dart';

class SubCategoryDropdown extends StatelessWidget {
  final String? selectedSubCategory;
  final List<String> subCategories;
  final ValueChanged<String?> onSubCategoryChanged;

  SubCategoryDropdown({
    required this.selectedSubCategory,
    required this.subCategories,
    required this.onSubCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sub Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedSubCategory,
          items: subCategories.map((subCategory) {
            return DropdownMenuItem<String>(
              value: subCategory,
              child: Text(subCategory),
            );
          }).toList(),
          onChanged: onSubCategoryChanged,
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
