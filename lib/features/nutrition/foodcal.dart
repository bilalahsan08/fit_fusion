import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItem {
  final String name;
  final int calories;
  final double carbs;
  final double fats;
  final double protein;
  final String category;

  FoodItem(this.name, this.calories, this.carbs, this.fats, this.protein, this.category);
}

class Foodcal extends StatefulWidget {
  const Foodcal({super.key});

  @override
  State<Foodcal> createState() => _FoodcalState();
}

class _FoodcalState extends State<Foodcal> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Protein',
    'Fruits',
    'Veggies',
    'Grains & Nuts',
    'Dairy'
  ];

  final List<FoodItem> allFoods = [
    // Fruits
    FoodItem("Apple", 95, 25.0, 0.3, 0.5, "Fruits"),
    FoodItem("Banana", 105, 27.0, 0.3, 1.3, "Fruits"),
    FoodItem("Orange", 62, 15.0, 0.2, 1.2, "Fruits"),
    FoodItem("Pineapple", 50, 13.1, 0.1, 0.5, "Fruits"),
    FoodItem("Mango", 60, 15.0, 0.4, 0.8, "Fruits"),
    FoodItem("Strawberries", 32, 7.7, 0.3, 0.7, "Fruits"),
    FoodItem("Blueberries", 84, 21.4, 0.5, 1.1, "Fruits"),
    FoodItem("Watermelon", 30, 7.6, 0.2, 0.6, "Fruits"),
    FoodItem("Grapes", 69, 18.1, 0.2, 0.7, "Fruits"),
    // Protein
    FoodItem("Chicken Breast", 165, 0.0, 3.6, 31.0, "Protein"),
    FoodItem("Salmon", 232, 0.0, 13.0, 25.0, "Protein"),
    FoodItem("Turkey Breast", 135, 0.0, 1.0, 30.0, "Protein"),
    FoodItem("Beef (Lean)", 250, 0.0, 9.0, 26.0, "Protein"),
    FoodItem("Whey Protein", 120, 3.0, 1.5, 24.0, "Protein"),
    FoodItem("Tofu", 76, 1.9, 4.8, 8.0, "Protein"),
    FoodItem("Tuna (Canned)", 132, 0.0, 1.0, 28.0, "Protein"),
    FoodItem("Shrimp", 99, 0.2, 0.3, 24.0, "Protein"),
    FoodItem("Pork Chop (Lean)", 197, 0.0, 9.0, 27.0, "Protein"),
    FoodItem("Tempeh", 192, 9.0, 11.0, 19.0, "Protein"),
    // Veggies
    FoodItem("Broccoli", 55, 11.0, 0.6, 3.7, "Veggies"),
    FoodItem("Spinach", 23, 3.6, 0.4, 2.9, "Veggies"),
    FoodItem("Kale", 33, 6.7, 0.6, 2.9, "Veggies"),
    FoodItem("Cucumber", 16, 3.6, 0.1, 0.7, "Veggies"),
    FoodItem("Tomato", 22, 4.8, 0.2, 1.1, "Veggies"),
    FoodItem("Zucchini", 17, 3.1, 0.3, 1.2, "Veggies"),
    FoodItem("Sweet Potato", 112, 26.0, 0.1, 2.0, "Veggies"),
    FoodItem("Carrots", 41, 9.6, 0.2, 0.9, "Veggies"),
    FoodItem("Bell Pepper", 20, 4.6, 0.2, 0.9, "Veggies"),
    FoodItem("Cauliflower", 25, 5.0, 0.3, 1.9, "Veggies"),
    // Grains & Nuts
    FoodItem("Rice", 206, 45.0, 0.4, 4.3, "Grains & Nuts"),
    FoodItem("Almonds", 164, 6.1, 14.2, 6.0, "Grains & Nuts"),
    FoodItem("Oats", 150, 27.0, 3.0, 5.0, "Grains & Nuts"),
    FoodItem("Quinoa", 222, 39.4, 3.6, 8.1, "Grains & Nuts"),
    FoodItem("Chia Seeds", 138, 12.0, 8.0, 4.7, "Grains & Nuts"),
    FoodItem("Peanut Butter", 188, 6.0, 16.0, 8.0, "Grains & Nuts"),
    FoodItem("Lentils", 116, 20.1, 0.4, 9.0, "Grains & Nuts"),
    FoodItem("Pumpkin Seeds", 151, 5.0, 13.0, 7.0, "Grains & Nuts"),
    FoodItem("Walnuts", 185, 4.0, 18.0, 4.3, "Grains & Nuts"),
    FoodItem("Whole Wheat Bread", 69, 12.0, 1.1, 3.6, "Grains & Nuts"),
    // Dairy
    FoodItem("Egg", 78, 0.6, 5.0, 6.0, "Dairy"),
    FoodItem("Milk", 103, 12.0, 2.4, 8.0, "Dairy"),
    FoodItem("Yogurt", 59, 3.6, 3.3, 5.0, "Dairy"),
    FoodItem("Greek Yogurt", 120, 6.0, 0.8, 10.0, "Dairy"),
    FoodItem("Cottage Cheese", 206, 6.0, 9.0, 28.0, "Dairy"),
    FoodItem("Cheddar Cheese", 113, 0.4, 9.0, 7.0, "Dairy"),
    FoodItem("Almond Milk (Unsweetened)", 15, 1.0, 1.0, 0.5, "Dairy"),
  ];

  List<FoodItem> get filteredFoods {
    return allFoods.where((food) {
      final matchesCategory = _selectedCategory == 'All' || food.category == _selectedCategory;
      final matchesSearch = food.name.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _clearInput() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayFoods = filteredFoods;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Food Calories',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search food (e.g., rice, greek yogurt)',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: const Icon(Icons.search_rounded, color: Colors.blue),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                          onPressed: _clearInput,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Filter Chips Row
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedColor: Colors.blue.shade600,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: displayFoods.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: displayFoods.length,
                      itemBuilder: (context, index) {
                        return _buildFoodCard(displayFoods[index]);
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            'No foods found',
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(FoodItem food) {
    final double totalMacros = food.protein + food.carbs + food.fats;
    final double proteinPct = totalMacros == 0 ? 0 : food.protein / totalMacros;
    final double carbsPct = totalMacros == 0 ? 0 : food.carbs / totalMacros;
    final double fatsPct = totalMacros == 0 ? 0 : food.fats / totalMacros;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  food.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_fire_department_rounded, size: 16, color: Colors.orange.shade700),
                    const SizedBox(width: 4),
                    Text(
                      '${food.calories} kcal',
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Per 100g serving',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          // Visual Macro Segmented Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                if (proteinPct > 0)
                  Expanded(
                    flex: (proteinPct * 100).toInt(),
                    child: Container(height: 8, color: Colors.red.shade400),
                  ),
                if (carbsPct > 0)
                  Expanded(
                    flex: (carbsPct * 100).toInt(),
                    child: Container(height: 8, color: Colors.orange.shade400),
                  ),
                if (fatsPct > 0)
                  Expanded(
                    flex: (fatsPct * 100).toInt(),
                    child: Container(height: 8, color: Colors.blue.shade400),
                  ),
                if (totalMacros == 0)
                  Expanded(
                    child: Container(height: 8, color: Colors.grey.shade300),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Macro Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroBadge("Protein", "${food.protein}g", Colors.red.shade400),
              _buildMacroBadge("Carbs", "${food.carbs}g", Colors.orange.shade400),
              _buildMacroBadge("Fats", "${food.fats}g", Colors.blue.shade400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBadge(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          "$label ",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}
