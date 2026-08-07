import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Data Models ---
class WellnessTip {
  final String id;
  final String category;
  final String title;
  final String description;
  final String takeaway;
  final IconData icon;
  final Color themeColor;
  bool isFavorite;

  WellnessTip({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.takeaway,
    required this.icon,
    required this.themeColor,
    this.isFavorite = false,
  });
}

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Nutrition', 'Hydration', 'Supplements', 'Recovery'];

  final List<WellnessTip> _allTips = [
    WellnessTip(
      id: 't1',
      category: 'Nutrition',
      title: 'Eat 5-6 Times a Day',
      description: 'You should eat every 2 or 3 hours. Consume 300–1200 calories in every meal, depending on your goal. This keeps your metabolism active and prevents overeating later in the day.',
      takeaway: '💡 Action: Space your meals out evenly to sustain energy.',
      icon: Icons.restaurant_menu_rounded,
      themeColor: Colors.green,
    ),
    WellnessTip(
      id: 't2',
      category: 'Nutrition',
      title: 'Prioritize Protein',
      description: 'One gram of protein contains 4 calories. Physically active people should eat at least 1.6 to 2.2 grams of protein per kg of their body weight to maintain and grow muscles efficiently.',
      takeaway: '💡 Action: Aim for at least 20g of protein per meal.',
      icon: Icons.fitness_center_rounded,
      themeColor: Colors.deepPurple,
    ),
    WellnessTip(
      id: 't3',
      category: 'Nutrition',
      title: 'Carbohydrates for Energy',
      description: 'Carbs provide the primary fuel for your workouts. Consume quality sources like oats, brown rice, and sweet potatoes. If you are struggling to gain weight, eat them generously.',
      takeaway: '💡 Action: Eat complex carbs 1-2 hours before training.',
      icon: Icons.bolt_rounded,
      themeColor: Colors.orange,
    ),
    WellnessTip(
      id: 't4',
      category: 'Hydration',
      title: 'The Water Rule',
      description: 'Higher protein intake demands more water. Drink at least 2L of water per day, plus an additional 500ml for every hour of intense exercise to support kidney health and muscle hydration.',
      takeaway: '💡 Action: Drink 500ml of water immediately upon waking up.',
      icon: Icons.water_drop_rounded,
      themeColor: Colors.blue,
    ),
    WellnessTip(
      id: 't5',
      category: 'Supplements',
      title: 'Smart Supplementation',
      description: 'Use supplements as additions to your diet, not replacements for whole foods. Whey protein, creatine, and omega-3s are the most research-backed supplements for fitness enthusiasts.',
      takeaway: '💡 Action: Focus on whole foods first; use whey for convenience.',
      icon: Icons.medication_liquid_rounded,
      themeColor: Colors.teal,
    ),
    WellnessTip(
      id: 't6',
      category: 'Recovery',
      title: 'Sleep is the Ultimate Steroid',
      description: 'Your muscles do not grow in the gym; they grow while you sleep. Aim for 7-9 hours of quality sleep per night to maximize growth hormone release and central nervous system recovery.',
      takeaway: '💡 Action: Keep a consistent sleep schedule even on weekends.',
      icon: Icons.nights_stay_rounded,
      themeColor: Colors.indigo,
    ),
  ];

  void _toggleFavorite(String id) {
    setState(() {
      final tip = _allTips.firstWhere((t) => t.id == id);
      tip.isFavorite = !tip.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter tips based on category
    final List<WellnessTip> displayedTips = _selectedCategory == 'All'
        ? _allTips
        : _allTips.where((t) => t.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Wellness Tips',
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
          // --- Hero Tip of the Day (Only show on 'All' tab) ---
          if (_selectedCategory == 'All')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: _buildHeroBanner(),
            ),

          // --- Category Filter Chips ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: _categories.map((cat) {
                  final bool isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                      selectedColor: Colors.blue.shade600,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // --- Tips List ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: displayedTips.length,
              itemBuilder: (context, index) {
                final tip = displayedTips[index];
                return _buildTipCard(tip);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade700, Colors.deepPurple.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "TIP OF THE DAY",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.auto_awesome_rounded, color: Colors.white60),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Consistency over intensity.",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "A mediocre plan executed consistently will always beat a perfect plan executed rarely. Show up every day.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(WellnessTip tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tip.themeColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(tip.icon, color: tip.themeColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tip.category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: tip.themeColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _toggleFavorite(tip.id),
                            child: Icon(
                              tip.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: tip.isFavorite ? Colors.redAccent : Colors.grey.shade400,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tip.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Key Takeaway Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: tip.themeColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              border: Border(
                top: BorderSide(color: tip.themeColor.withValues(alpha: 0.1)),
              ),
            ),
            child: Text(
              tip.takeaway,
              style: TextStyle(
                color: tip.themeColor.withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
