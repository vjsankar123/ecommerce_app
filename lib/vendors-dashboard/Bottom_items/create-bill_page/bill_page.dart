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
  List<Map<String, dynamic>> items = [];

  void _addItem() {
    setState(() {
      items.add({
        "description": "",
        "quantity": 0,
        "mrp": 0,
        "unitPrice": 0,
        "tax": 0,
        "total": 0,
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _updateItem(int index, String key, dynamic value) {
    setState(() {
      items[index][key] = value;
      items[index]["total"] =
          (items[index]["quantity"] * items[index]["unitPrice"]) +
              items[index]["tax"];
    });
  }

  double _calculateTotalAmount() {
    return items.fold(0.0, (sum, item) => sum + item["total"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Invoice Form")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Colors.black,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Customer Name",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Colors.black,
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Colors.black,
              ),
              SizedBox(height: 16),
              Text("Item Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: DataTable(
                    columnSpacing: 15,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey.shade300),
                    border: TableBorder.all(color: Colors.black),
                    columns: [
                      DataColumn(
                          label: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text("Quantity",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("MRP",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Unit Price",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Tax",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Action",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                    rows: List.generate(items.length, (index) {
                      var item = items[index];
                      return DataRow(cells: [
                        DataCell(TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) =>
                              _updateItem(index, "description", value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(border: InputBorder.none),
                        )),
                        DataCell(TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _updateItem(
                                index, "quantity", int.tryParse(value) ?? 0),
                            cursorColor: Colors.black,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: item["quantity"].toString()))),
                        DataCell(TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          onChanged: (value) => _updateItem(
                              index, "mrp", double.tryParse(value) ?? 0),
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: TextEditingController(
                              text: item["mrp"].toString()),
                        )),
                        DataCell(TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          onChanged: (value) => _updateItem(
                              index, "unitPrice", double.tryParse(value) ?? 0),
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: TextEditingController(
                              text: item["unitPrice"].toString()),
                        )),
                        DataCell(TextField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateItem(
                              index, "tax", double.tryParse(value) ?? 0),
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: TextEditingController(
                              text: item["tax"].toString()),
                        )),
                        DataCell(Text("₹${item["total"].toStringAsFixed(2)}")),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        )),
                      ]);
                    }),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addItem,
                child: Text(
                  "Add Item",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Text("Total Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("₹ ${_calculateTotalAmount().toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
