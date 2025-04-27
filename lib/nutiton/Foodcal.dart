import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Foodcal extends StatefulWidget{
  @override
  State<Foodcal> createState() => _FoodcalState();
}

class _FoodcalState extends State<Foodcal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Softer grey
      appBar: AppBar(
        backgroundColor: Colors.grey[50], // Almost white
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          '🍽️ Food Calorie Table',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            children: [
              _buildCategoryCard(
                title: "🥛 Milk and Dairy Products",
                items: [
                  ["Milk (0.9%)", "40", "4.7", "3.3", "0.9"],
                  ["Milk (3.2%)", "66", "4.7", "3.3", "3.2"],
                  ["Yogurt", "40", "5", "4", "4"],
                  ["Sour cream", "192", "3", "3", "18"],
                  ["Sweet cream", "317", "2", "3", "32"],
                  ["Pudding", "134", "21", "3.5", "4"],
                ],
              ),
              _buildCategoryCard(
                title: "🥩 Meat and Meat Products",
                items: [
                  ["Kidney (veal)", "121", "1", "15", "6"],
                  ["Hot dog (beef/pork)", "320", "2", "11", "29"],
                  ["Chicken (white)", "144", "0", "21", "3"],
                  ["Bacon", "605", "0", "8", "60"],
                  ["Pork", "345", "0", "18", "27"],
                ],
              ),
              _buildCategoryCard(
                title: "🍎 Fruits",
                items: [
                  ["Pineapple", "56", "13", "0", "0"],
                  ["Banana", "99", "23", "1", "0"],
                  ["Apple", "52", "12", "0", "0"],
                  ["Strawberry", "36", "7", "1", "0"],
                  ["Watermelon", "24", "5", "1", "0"],
                ],
              ),
              _buildCategoryCard(
                title: "🥦 Vegetables",
                items: [
                  ["Broccoli", "33", "4", "3", "0"],
                  ["Beet", "37", "8", "2", "0"],
                  ["Cucumber", "10", "2", "1", "0"],
                  ["Onion", "42", "9", "1", "0"],
                  ["Carrot", "35", "7", "1", "0"],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({required String title, required List<List<String>> items}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey[300]),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  children: [
                    _cell("Grocerie", isHeader: true),
                    _cell("Kcal", isHeader: true),
                    _cell("C", isHeader: true),
                    _cell("P", isHeader: true),
                    _cell("F", isHeader: true),
                  ],
                ),
                ...items.map((e) => _row(e[0], e[1], e[2], e[3], e[4])).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _row(String name, String kcal, String c, String p, String f) {
    return TableRow(
      children: [
        _cell(name),
        _cell(kcal),
        _cell(c),
        _cell(p),
        _cell(f),
      ],
    );
  }

  Widget _cell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
          fontSize: isHeader ? 14 : 13,
          color: isHeader ? Colors.blueAccent : Colors.black87,
        ),
      ),
    );
  }
}