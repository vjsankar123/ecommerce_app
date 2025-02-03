import 'package:ecommerce_app/vendors-dashboard/Bottom_items/home-pages/home_cards.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              MonthlyStackedBarChart(),
              SizedBox(height: 20),
              // MonthlyLineChart(),
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

class MonthlyStackedBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalSales = getTotalSales(getChartData()); // Calculate total sales
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Monthly Sales Distribution",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.3,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                StackedBarSeries<SalesData, String>(
                  dataSource: getChartData(),
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  pointColorMapper: (SalesData sales, _) {
                    // Dynamically change color based on the sales value
                    if (sales.sales > 25) {
                      return Colors.green;
                    } else if (sales.sales > 20) {
                      return Colors.blue;
                    } else {
                      return Colors.red;
                    }
                  },
                  name: 'Sales',
                  // Add a data label to display the percentage on the bars
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                      double percentage = (point.yValue / totalSales) * 100;
                      return Text('${percentage.toStringAsFixed(2)}%'); // Show percentage
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

  List<SalesData> getChartData() {
    return [
      SalesData('Jan', 20),
      SalesData('Feb', 15),
      SalesData('Mar', 18),
      SalesData('Apr', 25),
      SalesData('May', 22),
      SalesData('Jun', 30),
    ];
  }

  // Calculate total sales
  double getTotalSales(List<SalesData> data) {
    double total = 0;
    data.forEach((salesData) {
      total += salesData.sales;
    });
    return total;
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}
