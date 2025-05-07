import 'package:flutter/material.dart';

class FoodItem {
  final String name;
  final int calories;
  final double carbs;
  final double fats;
  final double protein;

  FoodItem(this.name, this.calories, this.carbs, this.fats, this.protein);
}

class Foodcal extends StatefulWidget {
  @override
  _FoodcalState createState() => _FoodcalState();
}

class _FoodcalState extends State<Foodcal> {
  final TextEditingController _searchController = TextEditingController();

  final List<FoodItem> allFoods = [
    FoodItem("Apple", 95, 25.0, 0.3, 0.5),
    FoodItem("Banana", 105, 27.0, 0.3, 1.3),
    FoodItem("Chicken Breast", 165, 0.0, 3.6, 31.0),
    FoodItem("Rice", 206, 45.0, 0.4, 4.3),
    FoodItem("Almonds", 164, 6.1, 14.2, 6.0),
    FoodItem("Oats", 150, 27.0, 3.0, 5.0),
    FoodItem("Egg", 78, 0.6, 5.0, 6.0),
    FoodItem("Milk", 103, 12.0, 2.4, 8.0),
    FoodItem("Orange", 62, 15.0, 0.2, 1.2),
    FoodItem("Broccoli", 55, 11.0, 0.6, 3.7),
    FoodItem("Yogurt", 59, 3.6, 3.3, 5.0),
    FoodItem("Tofu", 76, 1.9, 4.8, 8.0),
    FoodItem("Spinach", 23, 3.6, 0.4, 2.9),
    FoodItem("Salmon", 232, 0.0, 13.0, 25.0),
    FoodItem("Quinoa", 222, 39.4, 3.6, 8.1),
    FoodItem("Sweet Potato", 112, 26.0, 0.1, 2.0),
    FoodItem("Greek Yogurt", 120, 6.0, 0.8, 10.0),
    FoodItem("Cottage Cheese", 206, 6.0, 9.0, 28.0),
    FoodItem("Chia Seeds", 138, 12.0, 8.0, 4.7),
    FoodItem("Peanut Butter", 188, 6.0, 16.0, 8.0),
    FoodItem("Avocado", 160, 8.5, 15.0, 2.0),
    FoodItem("Lentils", 116, 20.1, 0.4, 9.0),
    FoodItem("Kale", 33, 6.7, 0.6, 2.9),
    FoodItem("Turkey Breast", 135, 0.0, 1.0, 30.0),
    FoodItem("Cucumber", 16, 3.6, 0.1, 0.7),
    FoodItem("Tomato", 22, 4.8, 0.2, 1.1),
    FoodItem("Whey Protein", 120, 3.0, 1.5, 24.0),
    FoodItem("Zucchini", 17, 3.1, 0.3, 1.2),
    FoodItem("Beef (Lean)", 250, 0.0, 9.0, 26.0),
    FoodItem("Pineapple", 50, 13.1, 0.1, 0.5),
    FoodItem("Mango", 60, 15.0, 0.4, 0.8),
    FoodItem("Pumpkin Seeds", 151, 5.0, 13.0, 7.0),

  ];

  List<FoodItem> searchResults = [];
  String error = '';

  void _searchFood() {
    final input = _searchController.text.trim().toLowerCase();

    final matches = allFoods
        .where((food) => food.name.toLowerCase().contains(input))
        .toList();

    setState(() {
      searchResults = matches;
      error = matches.isEmpty ? 'No matching foods found' : '';
    });
  }

  void _clearInput() {
    _searchController.clear();
    setState(() {
      searchResults.clear();
      error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Food Calories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter food name (e.g., rice, greek yogurt )',
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: _clearInput,
                        ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchFood,
                      ),
                    ],
                  ),
                ),
                onSubmitted: (_) => _searchFood(),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      offset: Offset(0, 2),
                      color: Colors.black12,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orangeAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Calories give your body energy. Track your food’s macros — carbs, fats, and protein — to stay balanced and healthy.',
                        style: TextStyle(color: Colors.grey[800], fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: searchResults.isNotEmpty
                    ? ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final food = searchResults[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildNutrientRow("Calories", "${food.calories} kcal"),
                            _buildNutrientRow("Carbs", "${food.carbs} g"),
                            _buildNutrientRow("Fats", "${food.fats} g"),
                            _buildNutrientRow("Protein", "${food.protein} g"),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : error.isNotEmpty
                    ? Center(
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
                    : Center(
                  child: Text(
                    'Start typing to search for a food item...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}