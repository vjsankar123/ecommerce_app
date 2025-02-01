import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InvoiceScreen(),
  ));
}

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Map<String, dynamic>> items = [
    {
      "description": "",
      "quantity": 1,
      "mrp": 0.0,
      "unitPrice": 0.0,
      "tax": 0.0,
      "total": 0.0,
    }
  ];

  void _addItem() {
    setState(() {
      items.add({
        "description": "",
        "quantity": 1,
        "mrp": 0.0,
        "unitPrice": 0.0,
        "tax": 0.0,
        "total": 0.0,
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _calculateTotal(int index) {
    setState(() {
      double quantity = items[index]['quantity'].toDouble();
      double unitPrice = items[index]['unitPrice'].toDouble();
      double tax = items[index]['tax'].toDouble();
      items[index]['total'] = (quantity * unitPrice) + tax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Invoice"),
      //   backgroundColor: Colors.purple,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(
                    labelText: "Mobile Number", border: OutlineInputBorder())),
            SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(
                    labelText: "Customer Name", border: OutlineInputBorder())),
            SizedBox(height: 8),
            TextField(
                decoration: InputDecoration(
                    labelText: "Address", border: OutlineInputBorder())),
            SizedBox(height: 16),

            Text("Item Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            // Enables both Horizontal and Vertical Scrolling

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
