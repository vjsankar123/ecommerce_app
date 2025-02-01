import 'package:ecommerce_app/vendors-dashboard/Bottom_items/home-pages/home_cards.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildStatusCards(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildStatusCards(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          children: [
            CustomCard(
              title: "Total Amount",
              data: "1234567",
              color: Color(0xFF3B82F6),
              icon: Icons.currency_rupee,
            ),
            CustomCard(
              title: "Product",
              data: "4567",
              color: Color(0xFF22C55E),
              icon: Icons.shopping_cart,
            ),
          ],
        ),
      ),
      SizedBox(width: 2),
      Expanded(
        child: Column(
          children: [
            CustomCard(
              title: "Orders",
              data: "23456",
              color: Color(0xFFEF4444),
              icon: Icons.check_circle,
            ),
            CustomCard(
              title: "Out Of Stock",
              data: "5678",
              color: Color(0xFFEAB308),
              icon: Icons.outbound,
            ),
          ],
        ),
      ),
    ],
  );
}
