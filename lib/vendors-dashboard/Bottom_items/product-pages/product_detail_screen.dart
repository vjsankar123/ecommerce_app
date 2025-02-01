import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String imagePath;
  final String category;
  final String subcategory;
  final String color;
  final String size;
  final String mrp;
  final String stock;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.category,
    required this.subcategory,
    required this.color,
    required this.size,
    required this.mrp,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.purple,
        elevation: 5,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath,
                  width: double.infinity, height: 450, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              name,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Product Category and Subcategory
            _buildProductInfo("Category", category),
            _buildProductInfo("Subcategory", subcategory),
            _buildProductInfo("Color", color),
            _buildProductInfo("Size", size),
            _buildProductInfo("Stock", stock),
            _buildProductInfo("MRP", mrp, isPrice: true),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isPrice ? Colors.red : Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: isPrice ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
