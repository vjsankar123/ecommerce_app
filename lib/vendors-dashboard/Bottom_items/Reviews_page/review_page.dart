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
        Navigator.of(context).pop();
      },
    );
  }

  double get averageRating {
    double totalRating = 0;
    for (var review in reviews) {
      totalRating += review.rating;
    }
    return totalRating / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // centerTitle: true,
        title: Text(
          'Reviews',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold, // Bold text for better visibility
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
                // **Vendor Rating Summary**
                RatingSummary(
                  rating: averageRating,
                  totalReviews: reviews.length,
                  starCounts: List.generate(5, (index) {
                    return reviews.where((review) => review.rating.floor() == 5 - index).length;
                  }),
                ),
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
}
class RatingSummary extends StatelessWidget {
  final double rating;
  final int totalReviews;
  final List<int> starCounts;

  RatingSummary({
    required this.rating,
    required this.totalReviews,
    required this.starCounts,
  });

  // Method to build stat card
  Widget _buildStatCard(String title, String value, String percentage, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(value, style: TextStyle(fontSize: 16, color: color)),
        if (percentage.isNotEmpty)
          Text(percentage, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
      width: 500,  // Increased width here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCard("Total Reviews", "10.0k", "⬆ 21%", Colors.blue),
          _buildStatCard("Average Rating", "4.0 ⭐", "", Colors.orange),
          SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating.floor()
                    ? Icons.star
                    : index < rating
                        ? Icons.star_half
                        : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
          SizedBox(height: 8),
          Column(
            children: List.generate(5, (index) {
              return Row(
                children: [
                  Text('${5 - index} Star', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(20),
                      value: starCounts[index] / totalReviews,
                      backgroundColor: Colors.grey[300],
                      color: Colors.amber,
                      minHeight: 6,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
