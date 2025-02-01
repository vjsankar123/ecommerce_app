import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final List<String> genders;
  final ValueChanged<String?> onGenderChanged;

  GenderDropdown({
    required this.selectedGender,
    required this.genders,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedGender,
          items: genders.map((gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: onGenderChanged,
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
