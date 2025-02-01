import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:confetti/confetti.dart';
import 'package:quickalert/quickalert.dart';

class Review {
  final String productName;
  final String userName;
  final double rating;
  final String description;
  final String date;

  Review({
    required this.productName,
    required this.userName,
    required this.rating,
    required this.description,
    required this.date,
  });
}

List<Review> reviews = [
  Review(
    productName: 'Nike Shoes',
    userName: 'Virat',
    rating: 4.5,
    description: 'Great products and fast shipping!',
    date: '2025-01-25',
  ),
  Review(
    productName: 'Adidas T-shirt',
    userName: 'Raina',
    rating: 3.0,
    description: 'Quality could be better, but service is good.',
    date: '2025-01-20',
  ),
  Review(
    productName: 'Puma Sneakers',
    userName: 'Dhoni',
    rating: 5.0,
    description: 'Excellent customer service. Highly recommended!',
    date: '2025-01-18',
  ),
];

class VendorReviewPage extends StatefulWidget {
  final String vendorName;
  final String vendorImageUrl;

  VendorReviewPage({
    required this.vendorName,
    required this.vendorImageUrl,
  });

  @override
  _VendorReviewPageState createState() => _VendorReviewPageState();
}

class _VendorReviewPageState extends State<VendorReviewPage> {
  Map<int, bool> expandedState = {};
  Map<int, bool> verifiedState = {};
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _verifyReview(int index) {
    _confettiController.play();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Review Verified Successfully!',
      confirmBtnText: 'OK',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        setState(() {
          verifiedState[index] = true;
        });
        Navigator.of(context).pop(); // Move this outside setState
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reviews',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // **Stats Cards Section**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("Total Reviews", "10.0k", "⬆ 21%", Colors.blue),
                    _buildStatCard("Average Rating", "4.0 ⭐", "", Colors.orange),
                  ],
                ),
                SizedBox(height: 12),
                _buildRatingBreakdown(),

 SizedBox(height: 15),
                // **Reviews List**
                Expanded(
                  child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      bool isExpanded = expandedState[index] ?? false;
                      bool isVerified = verifiedState[index] ?? false;
                      bool showReadMoreButton = review.description.length > 50;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            expandedState[index] = !(expandedState[index] ?? false);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    review.productName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.blueAccent,
                                      child: Text(
                                        review.userName[0],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          review.date,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    RatingBarIndicator(
                                      rating: review.rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Reviews:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        review.description.length > 50 && !isExpanded
                                            ? review.description.substring(0, 50) + '...'
                                            : review.description,
                                        style: TextStyle(fontSize: 14),
                                        maxLines: isExpanded ? null : 2,
                                        overflow: isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (showReadMoreButton)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            expandedState[index] = !isExpanded;
                                          });
                                        },
                                        child: Text(
                                          isExpanded ? "Read Less" : "Read More",
                                          style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if (isExpanded)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: isVerified
                                          ? null
                                          : () => _verifyReview(index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            isVerified ? Colors.green : Colors.red,
                                      ),
                                      child: Text(
                                        isVerified ? 'Verified' : 'Verify',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // **Stat Card Widget**
  Widget _buildStatCard(String title, String value, String change, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 4), // Equal margin on both sides
        constraints: BoxConstraints(minHeight: 110), // Ensuring both cards have the same height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            if (change.isNotEmpty)
              Text(
                change,
                style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  // **Rating Breakdown Widget**
  Widget _buildRatingBreakdown() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rating Breakdown",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildRatingRow(5, "2.0k"),
          _buildRatingRow(4, "1.0k"),
          _buildRatingRow(3, "500"),
          _buildRatingRow(2, "200"),
          _buildRatingRow(1, "0"),
        ],
      ),
    );
  }

  // **Rating Row Widget**
  Widget _buildRatingRow(int stars, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$stars ⭐"),
          Spacer(),
          Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
