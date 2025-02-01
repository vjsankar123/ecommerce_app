import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-product/sub_category_dropdown.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/product-pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'product_input_field.dart';
import 'category_dropdown.dart';
import 'gender_dropdown.dart';
import 'size_field.dart';
import 'image_picker_widget.dart';

void main() {
  runApp(MaterialApp(home: CreateProductScreen()));
}

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedGender;
  String productName = '';
  String color = '';
  int quantity = 1;
  String description = '';
  String materialType = '';
  String fitType = '';
  String sleeveType = '';
  String patternType = '';
  double mrpPrice = 0.0;
  double sellingPrice = 0.0;
  double offerPercentage = 0.0;
  String gstin = '';
  String countryOfOrigin = '';
  String sellerName = '';
  String sellerLocation = '';
  String imagePath = '';

  final ImagePicker _picker = ImagePicker();

  final Map<String, List<String>> categoriesWithSubcategories = {
    'T-Shirts': ['Casual', 'Formal', 'Sports'],
    'Bottoms': ['Jeans', 'Shorts', 'Sweatpants'],
    'Accessories': ['Bags', 'Watches', 'Jewelry'],
    'Footwear': ['Sneakers', 'Boots', 'Flats'],
    'Wear': ['Outerwear', 'Activewear', 'Sleepwear'],
  };

  List<String> subCategories = [];
  final List<String> genders = ['Male', 'Female', 'Other'];

  List<Map<String, dynamic>> sizeFields = [
    {'size': 'M', 'quantity': 1}
  ];

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController materialTypeController = TextEditingController();
  final TextEditingController fitTypeController = TextEditingController();
  final TextEditingController sleeveTypeController = TextEditingController();
  final TextEditingController patternTypeController = TextEditingController();
  final TextEditingController mrpPriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController offerPercentageController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController countryOfOriginController = TextEditingController();
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerLocationController = TextEditingController();

  void addSizeField() {
    setState(() {
      sizeFields.add({'size': 'M', 'quantity': 1});
    });
  }

  void _createProduct() {
    Map<String, String> newProduct = {
      "name": productNameController.text,
      "category": selectedCategory ?? '',
      "subcategory": selectedSubCategory ?? '',
      "mrp": '₹$mrpPrice',
      "imagePath": imagePath,
      "color": colorController.text,
      "size": sizeFields.map((e) => e['size']).join(', '),
      "stock": quantity.toString(),
    };

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProductCardScreen(newProduct: newProduct),
    //   ),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product created successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void removeSizeField(int index) {
    if (sizeFields.length > 1) {
      setState(() {
        sizeFields.removeAt(index);
      });
    }
  }

  void handleSizeChange(int index, String? newSize) {
    setState(() {
      sizeFields[index]['size'] = newSize;
    });
  }

  void handleQuantityChange(int index, String quantity) {
    setState(() {
      sizeFields[index]['quantity'] = int.tryParse(quantity) ?? 1;
    });
  }

  @override
  void dispose() {
    productNameController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    materialTypeController.dispose();
    fitTypeController.dispose();
    sleeveTypeController.dispose();
    patternTypeController.dispose();
    mrpPriceController.dispose();
    sellingPriceController.dispose();
    offerPercentageController.dispose();
    gstinController.dispose();
    countryOfOriginController.dispose();
    sellerNameController.dispose();
    sellerLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Create Product',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CategoryDropdown(
              selectedCategory: selectedCategory,
              subCategories: categoriesWithSubcategories.keys.toList(),
              onCategoryChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  subCategories = categoriesWithSubcategories[value] ?? [];
                  selectedSubCategory = null;
                });
              },
            ),
            SizedBox(height: 10),
            SubCategoryDropdown(
              selectedSubCategory: selectedSubCategory,
              subCategories: subCategories,
              onSubCategoryChanged: (value) {
                setState(() {
                  selectedSubCategory = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: productNameController,
              label: 'Product Name',
              onChanged: (value) {
                setState(() {
                  productName = value;
                });
              },
            ),
            SizedBox(height: 10),
            GenderDropdown(
              selectedGender: selectedGender,
              genders: genders,
              onGenderChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: colorController,
              label: 'Color',
              onChanged: (value) {
                setState(() {
                  color = value;
                });
              },
            ),
            SizedBox(height: 10),
            SizeField(
              sizeFields: sizeFields,
              addSizeField: addSizeField,
              removeSizeField: removeSizeField,
              handleSizeChange: handleSizeChange,
              handleQuantityChange: handleQuantityChange,
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: descriptionController,
              label: 'Description',
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: materialTypeController,
              label: 'Material Type',
              onChanged: (value) {
                setState(() {
                  materialType = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: fitTypeController,
              label: 'Fit Type',
              onChanged: (value) {
                setState(() {
                  fitType = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: sleeveTypeController,
              label: 'Sleeve Type',
              onChanged: (value) {
                setState(() {
                  sleeveType = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: patternTypeController,
              label: 'Pattern Type',
              onChanged: (value) {
                setState(() {
                  patternType = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: mrpPriceController,
              label: 'MRP Price',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  mrpPrice = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: sellingPriceController,
              label: 'Selling Price',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  sellingPrice = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: offerPercentageController,
              label: 'Offer Percentage %',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  offerPercentage = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: gstinController,
              label: 'GSTin',
              onChanged: (value) {
                setState(() {
                  gstin = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: countryOfOriginController,
              label: 'Country of Origin',
              onChanged: (value) {
                setState(() {
                  countryOfOrigin = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: sellerNameController,
              label: 'Seller Name',
              onChanged: (value) {
                setState(() {
                  sellerName = value;
                });
              },
            ),
            SizedBox(height: 10),
            ProductInputField(
              controller: sellerLocationController,
              label: 'Seller Location',
              onChanged: (value) {
                setState(() {
                  sellerLocation = value;
                });
              },
            ),
            SizedBox(height: 10),
            MultiImagePickerWidget(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createProduct,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.purple,
              ),
              child: Text(
                'Create Product',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
