import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:ecommerce_app/Screens/login_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/Reviews_page/review_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-bill_page/bill_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/home-pages/home_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/product-pages/product_detail.dart';
import 'package:ecommerce_app/vendors-dashboard/shopdetail_page.dart';

class PersistentBottomNavBar extends StatefulWidget {
  @override
  _PersistentBottomNavBarState createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<PersistentBottomNavBar> {
  final _controller = NotchBottomBarController(index: 0);

  final List<Widget> _pages = [
    Homepage(),
    ProductCardScreen(),
    InvoiceScreen(),
    VendorReviewPage(vendorName: '', vendorImageUrl: '',),
    ShopdetailPage(),
  ];

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your LoginPage
                );
              },
              child: Text("Logout",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the app when the back button is pressed after logout
        return true; // This will close the app
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/boy.png'), // Change to your profile image
            ),
          ),
         title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 4),
                Text(
                  'Hi,Sankar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
          
        ),
          // centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.grey.shade200),
              onPressed: _logout, // Trigger the logout confirmation
            ),
          ],
        ),
        body: _pages[_controller.index], // Display page based on bottom bar index
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          onTap: (index) {
            setState(() {
              _controller.index = index.clamp(0, 4);
            });
          },
          kIconSize: 20,
          kBottomRadius: 30,
          elevation: 10,
          notchColor: Colors.purple,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Icon(Icons.home, color: Colors.black),
              activeItem: Center(
                child: Icon(Icons.home_outlined, color: Colors.white, size: 25),
              ),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.shopping_cart, color: Colors.black),
              activeItem: Center(
                child: Icon(Icons.production_quantity_limits,
                    color: Colors.white, size: 25),
              ),
              itemLabel: 'All Products',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.add_box, color: Colors.black),
              activeItem: Center(
                child: Icon(Icons.add_box, color: Colors.white, size: 25),
              ),
              itemLabel: 'Billing',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.reviews, color: Colors.black),
              activeItem: Center(
                child: Icon(Icons.reviews, color: Colors.white, size: 25),
              ),
              itemLabel: 'Reviews',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.shopping_bag, color: Colors.black),
              activeItem: Center(
                child: Icon(Icons.shopping_bag, color: Colors.white, size: 25),
              ),
              itemLabel: 'Orders',
            ),
          ],
          showLabel: true,
        ),
      ),
    );
  }
}
