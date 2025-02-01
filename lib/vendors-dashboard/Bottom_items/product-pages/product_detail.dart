import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-product/create_product.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductCardScreen extends StatefulWidget {
  final Map<String, String>? newProduct;

  const ProductCardScreen({super.key, this.newProduct});

  @override
  _ProductCardScreenState createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> products = [
    {
      "name": "Cool T-Shirt",
      "category": "T-shirts",
      "subcategory": "Full Sleeve",
      "mrp": "₹799",
      "imagePath": "assets/images/image1.jpg",
      "color": "Red",
      "size": "XS, M, L",
      "stock": "470",
    },
    {
      "name": "Casual Shirt",
      "category": "Bottoms",
      "subcategory": "Trousers",
      "mrp": "₹999",
      "imagePath": "assets/images/image2.jpg",
      "color": "Blue",
      "size": "XS, M, L",
      "stock": "450",
    },
  ];

  List<Map<String, String>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;

    if (widget.newProduct != null) {
      products.add(widget.newProduct!);
      filteredProducts = products;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSuccessMessage();
      });
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToAddProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProductScreen(),
      ),
    );

    if (newProduct != null && newProduct is Map<String, String>) {
      setState(() {
        products.add(newProduct);
        filteredProducts = products;
      });
      _showSuccessMessage();
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: isSearching
          ? Container(
              padding: const EdgeInsets.only(top: 2), // Adjust top padding
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search products...",
                   border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
            ),
                ),
                cursorColor: Colors.purple,
                onChanged: filterProducts,
              ),
            )
          : const Text(
              "Product List",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
              if (!isSearching) {
                searchController.clear();
                filteredProducts = products;
              }
            });
          },
        ),
      ],
      toolbarHeight: isSearching ? 90 : kToolbarHeight, // Adjust the height based on searching state
    ),
    backgroundColor: Colors.white,
    body: ListView(
      padding: const EdgeInsets.all(10),
      children: filteredProducts.map((product) {
        return ProductCard(
          name: product["name"]!,
          category: product["category"]!,
          subcategory: product["subcategory"]!,
          mrp: product["mrp"]!,
          imagePath: product["imagePath"]!,
          color: product["color"]!,
          size: product["size"]!,
          stock: product["stock"]!,
        );
      }).toList(),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _navigateToAddProduct,
      backgroundColor: Colors.purple,
      child: Icon(Icons.add, color: Colors.white),
    ),
  );
}
}