import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-product/create_product.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/product-pages/search_box.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductCardScreen extends StatefulWidget {
  final Map<String, String>? newProduct;

  const ProductCardScreen({super.key, this.newProduct});

  @override
  _ProductCardScreenState createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

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
          title: _isSearching
              ? SearchWidget(
                  controller: _searchController,
                )
              :FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Product List', // Adjusted title for flexibility
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold, // Bold text for better visibility
            ),
          ),
          
        ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.cancel : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) _searchController.clear();
                });
              },
            ),
          ],
          backgroundColor: Colors.white,
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
