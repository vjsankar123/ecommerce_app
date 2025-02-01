import 'package:ecommerce_app/Screens/login_page.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

const Color primaryColor = Color(0xFF4F46E5); // Indigo
const Color secondaryColor = Color(0xFF3B82F6); // Blue

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // routes: {
      //   '/': (context) => LandingPage(),
      //   '/dashboard': (context) => DashboardPage(),
      // },
    );
  }
}
