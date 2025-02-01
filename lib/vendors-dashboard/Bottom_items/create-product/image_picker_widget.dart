import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePickerWidget extends StatefulWidget {
  @override
  _MultiImagePickerWidgetState createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  List<String> imagePaths = []; // List to store image paths
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image
  Future<void> pickImage() async {
    // Pick image from gallery
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (imagePaths.length < 5) {
          imagePaths.add(pickedFile.path); // Use actual picked file path
        } else {
          // Optionally show a message that there can be only 5 images
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You can only upload a maximum of 5 images.')),
          );
        }
      });
    }
  }

  // Method to delete an image
  void deleteImage(int index) {
    setState(() {
      imagePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        imagePaths.isEmpty
            ? OutlinedButton(
                onPressed: pickImage,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  side: BorderSide(color: Colors.purple, width: 2),
                ),
                child: Text('Upload Images', style: TextStyle(fontSize: 16, color: Colors.black)),
              )
            : Column(
                children: List.generate(
                  imagePaths.length,
                  (index) => Row(
                    children: [
                      Image.file(
                        File(imagePaths[index]),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteImage(index),
                      ),
                    ],
                  ),
                ),
              ),
        SizedBox(height: 10),
        // Add more images button
        if (imagePaths.length < 5)
          OutlinedButton(
            onPressed: pickImage,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              side: BorderSide(color: Colors.purple, width: 2),
            ),
            child: Icon(Icons.add,size: 24.0,),
          ),
      ],
    );
  }
}
