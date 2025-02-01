import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/Reviews_page/review_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-bill_page/bill_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/create-product/create_product.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/home-pages/home_page.dart';
import 'package:ecommerce_app/vendors-dashboard/Bottom_items/product-pages/product_detail.dart';
import 'package:ecommerce_app/vendors-dashboard/pharmacy_page.dart';
import 'package:ecommerce_app/vendors-dashboard/shop_page.dart';
import 'package:ecommerce_app/vendors-dashboard/shopdetail_page.dart';
import 'package:flutter/material.dart';

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
  
// void _openBottomSheet() {
//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//     ),
//     isScrollControlled: true, // Ensures the full height of the screen is used
//     builder: (BuildContext context) {
//       return Container(
//         width: double.infinity, // Set full width
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Box 1
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Bill',
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Icon(Icons.arrow_forward_ios, color: Colors.grey), // Forward icon
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             // Box 2
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'List',
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Icon(Icons.arrow_forward_ios, color: Colors.grey), // Forward icon
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             // Box 3
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Others',
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Icon(Icons.arrow_forward_ios, color: Colors.grey), // Forward icon
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome ",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              "Sankar", // Replace with user's name dynamically
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              // Implement logout functionality here
            },
          ),
        ],
      ),
      body: _pages[_controller.index], // Display page based on bottom bar index
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.purple,
      //   child: Icon(Icons.add, color: Colors.white),
      // ),
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
            itemLabel: 'Create Product',
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
    );
  }
}
