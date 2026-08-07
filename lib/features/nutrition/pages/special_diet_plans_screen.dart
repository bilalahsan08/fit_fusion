import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_fusion/features/nutrition/pages/meal_detail_screen.dart';
import 'package:fit_fusion/core/models/meal.dart';

// --- Models ---
class SpecialDiet {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final Color color2;
  final String durationTag;
  final String difficultyTag;
  final int fatPercent;
  final int proPercent;
  final int carbPercent;
  final List<String> guidelines;
  final List<Meal> recipes;

  SpecialDiet({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.durationTag,
    required this.difficultyTag,
    required this.fatPercent,
    required this.proPercent,
    required this.carbPercent,
    required this.guidelines,
    required this.recipes,
  });
}

// --- Data ---
final List<SpecialDiet> specialDiets = [
  SpecialDiet(
    title: 'Keto Kickstart',
    subtitle: 'High fat, low carb metabolic reset.',
    icon: Icons.local_fire_department_rounded,
    color1: Colors.deepPurple.shade700,
    color2: Colors.purpleAccent.shade400,
    durationTag: '14-Day Reset',
    difficultyTag: 'Strict',
    fatPercent: 70,
    proPercent: 25,
    carbPercent: 5,
    guidelines: [
      'Keep net carbs under 20g per day.',
      'Embrace healthy fats (avocado, olive oil).',
      'Avoid sugar, grains, and starchy vegetables.',
      'Drink plenty of water and replenish electrolytes.',
    ],
    recipes: [
      Meal(
        id: 'keto_1',
        title: 'Avocado Egg Salad',
        calories: '450',
        prepTime: '10 Min',
        imagePath: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800&q=80',
        description: 'Mash avocado and eggs together. Stir in mayo and season. Serve in lettuce wraps.',
        weight: '300g',
        category: 'Keto',
      ),
      Meal(
        id: 'keto_2',
        title: 'Garlic Butter Salmon',
        calories: '520',
        prepTime: '20 Min',
        imagePath: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800&q=80',
        description: 'Pan-sear salmon in butter. Add minced garlic. Roast asparagus on the side.',
        weight: '400g',
        category: 'Keto',
      )
    ],
  ),
  SpecialDiet(
    title: 'Intermittent Fasting (16:8)',
    subtitle: 'Structured eating windows for fat loss.',
    icon: Icons.timer_rounded,
    color1: Colors.blue.shade800,
    color2: Colors.lightBlue.shade400,
    durationTag: 'Lifestyle',
    difficultyTag: 'Intermediate',
    fatPercent: 30,
    proPercent: 40,
    carbPercent: 30,
    guidelines: [
      'Fast for 16 hours, eat during an 8-hour window.',
      'Drink black coffee or green tea during fasts.',
      'Break fast with a high-protein, moderate-fat meal.',
      'Avoid snacking between main meals.',
    ],
    recipes: [
      Meal(
        id: 'if_1',
        title: 'Fasting Break Bowl',
        calories: '600',
        prepTime: '15 Min',
        imagePath: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
        description: 'Cook quinoa. Grill chicken breast. Mix with fresh spinach and dress with olive oil.',
        weight: '350g',
        category: 'Fasting',
      ),
      Meal(
        id: 'if_2',
        title: 'Lean Steak & Sweet Potato',
        calories: '750',
        prepTime: '25 Min',
        imagePath: 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80',
        description: 'Grill lean sirloin steak. Roast sweet potato wedges with rosemary. Serve with a side salad.',
        weight: '450g',
        category: 'Fasting',
      )
    ],
  ),
  SpecialDiet(
    title: 'High Protein Split',
    subtitle: 'Maximized muscle synthesis & recovery.',
    icon: Icons.fitness_center_rounded,
    color1: Colors.red.shade800,
    color2: Colors.orange.shade500,
    durationTag: 'Muscle Building',
    difficultyTag: 'Easy',
    fatPercent: 20,
    proPercent: 50,
    carbPercent: 30,
    guidelines: [
      'Consume 1.8g - 2.2g of protein per kg of bodyweight.',
      'Spread protein evenly across 4-5 meals.',
      'Consume whey protein post-workout.',
      'Prioritize lean meats, eggs, and dairy.',
    ],
    recipes: [
      Meal(
        id: 'pro_1',
        title: 'Protein Pancakes',
        calories: '380',
        prepTime: '15 Min',
        imagePath: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800&q=80',
        description: 'Blend ingredients into batter. Cook on non-stick pan. Top with sugar-free syrup.',
        weight: '250g',
        category: 'High Protein',
      ),
      Meal(
        id: 'pro_2',
        title: 'Grilled Chicken Quinoa',
        calories: '550',
        prepTime: '20 Min',
        imagePath: 'https://images.unsplash.com/photo-1534080564583-6be75777b70a?w=800&q=80',
        description: 'Grill chicken breast strips. Serve over cooked quinoa with steamed broccoli and lemon.',
        weight: '400g',
        category: 'High Protein',
      )
    ],
  ),
  SpecialDiet(
    title: 'Vegan Cleanse',
    subtitle: '100% Plant-based whole foods.',
    icon: Icons.spa_rounded,
    color1: Colors.teal.shade800,
    color2: Colors.green.shade500,
    durationTag: '7-Day Detox',
    difficultyTag: 'Medium',
    fatPercent: 25,
    proPercent: 25,
    carbPercent: 50,
    guidelines: [
      'Eliminate all animal products.',
      'Focus on whole grains, legumes, and dark leafy greens.',
      'Ensure adequate B12 and Iron intake.',
      'Incorporate tofu and tempeh for protein.',
    ],
    recipes: [
      Meal(
        id: 'vegan_1',
        title: 'Tofu Grain Bowl',
        calories: '420',
        prepTime: '25 Min',
        imagePath: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&q=80',
        description: 'Press and cube tofu, then bake. Steam broccoli. Serve over rice with soy sauce.',
        weight: '400g',
        category: 'Vegan',
      ),
      Meal(
        id: 'vegan_2',
        title: 'Hearty Lentil Soup',
        calories: '320',
        prepTime: '30 Min',
        imagePath: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&q=80',
        description: 'Simmer lentils with carrots, celery, and vegetable broth. Add fresh parsley.',
        weight: '350g',
        category: 'Vegan',
      )
    ],
  ),
];

// --- Screens ---
class SpecialDietPlansScreen extends StatelessWidget {
  const SpecialDietPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Diet Hub',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curated Nutrition',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a specialized plan to match your lifestyle and fitness goals.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ...specialDiets.map((diet) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildSpecialDietCard(context, diet),
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialDietCard(BuildContext context, SpecialDiet diet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpecialDietDetailScreen(diet: diet),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [diet.color1, diet.color2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(diet.icon, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            diet.title,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            diet.subtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildTag(diet.durationTag, Colors.blue.shade100, Colors.blue.shade800),
                              const SizedBox(width: 8),
                              _buildTag(diet.difficultyTag, Colors.orange.shade100, Colors.orange.shade800),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Macro Ratio Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMacroLabel('Fat ${diet.fatPercent}%', Colors.amber),
                    _buildMacroLabel('Pro ${diet.proPercent}%', Colors.blue),
                    _buildMacroLabel('Carb ${diet.carbPercent}%', Colors.green),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 8,
                    child: Row(
                      children: [
                        Expanded(flex: diet.fatPercent, child: Container(color: Colors.amber)),
                        Expanded(flex: diet.proPercent, child: Container(color: Colors.blue)),
                        Expanded(flex: diet.carbPercent, child: Container(color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildMacroLabel(String text, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
      ],
    );
  }
}

// --- Detail Screen ---
class SpecialDietDetailScreen extends StatelessWidget {
  final SpecialDiet diet;

  const SpecialDietDetailScreen({super.key, required this.diet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [diet.color1, diet.color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Icon(diet.icon, color: Colors.white, size: 60),
                      const SizedBox(height: 8),
                      Text(
                        diet.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Diet Rules & Guidelines",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: diet.guidelines
                          .map((rule) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.check_circle_outline_rounded,
                                        color: diet.color1, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        rule,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Curated Meals",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: diet.recipes.length,
                    itemBuilder: (context, index) {
                      final meal = diet.recipes[index];
                      return _buildRecipeCard(context, meal);
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailScreen(meal: meal),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                meal.imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text('${meal.calories} kcal',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
