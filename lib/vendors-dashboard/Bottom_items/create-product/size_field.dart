import 'package:flutter/material.dart';

class SizeField extends StatelessWidget {
  final List<Map<String, dynamic>> sizeFields;
  final VoidCallback addSizeField;
  final Function(int) removeSizeField;
  final Function(int, String?) handleSizeChange;
  final Function(int, String) handleQuantityChange;

  SizeField({
    required this.sizeFields,
    required this.addSizeField,
    required this.removeSizeField,
    required this.handleSizeChange,
    required this.handleQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for the size fields
        Text(
          'Size and Quantity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: sizeFields.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for size selection
                DropdownButtonFormField<String>(
                  value: sizeFields[index]['size'],
                  items: ['XS', 'S', 'M', 'L', 'XL', 'XXL'].map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) => handleSizeChange(index, value),
                  decoration: InputDecoration(
                    labelText: 'Size',
                    labelStyle: TextStyle(color: Colors.black),
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
                ),
                SizedBox(height: 10),
                // Text field for quantity input
                TextFormField(
                  initialValue: sizeFields[index]['quantity'].toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => handleQuantityChange(index, value),
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.black),
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
                
                SizedBox(height: 10),
                // Remove size field button (if more than one size field exists)
                if (sizeFields.length > 1)
                  ElevatedButton(
                    onPressed: () => removeSizeField(index),
                    child: Icon(Icons.delete_forever, color: Colors.red),
                  ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
        // Button to add new size field
        ElevatedButton(
          onPressed: addSizeField,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          child: Text('Add Size',style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
