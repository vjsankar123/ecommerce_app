import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final String subcategory;
  final String mrp;
  final String imagePath;
  final String color;
  final String size;
  final String stock;

  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.mrp,
    required this.imagePath,
    required this.color,
    required this.size,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            top: const BorderSide(color: Colors.black, width: 2.0),
            left: const BorderSide(color: Colors.black, width: 2.0),
            right: const BorderSide(color: Colors.black, width: 2.0),
            bottom: const BorderSide(color: Colors.black, width: 5.0),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("Category: $category",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      Text("Subcategory: $subcategory",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      Text("MRP: $mrp",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(imagePath,
                      width: 80, height: 80, fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.visibility, "See All", Colors.blue,
                    () {
                  _onSeeAllClick(context);
                }),
                _buildActionButton(Icons.edit, "Edit", Colors.orange, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Edit Product")));
                }),
                _buildActionButton(Icons.delete, "Delete", Colors.red, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Delete Product")));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color)),
    );
  }

  void _onSeeAllClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          name: name,
          imagePath: imagePath,
          category: category,
          subcategory: subcategory,
          color: color,
          size: size,
          mrp: mrp,
          stock: stock,
        ),
      ),
    );
  }
}
