import 'package:fit_fusion/core/models/meal.dart';
import 'package:fit_fusion/core/models/workout.dart';
import 'package:fit_fusion/core/models/exercise.dart';

class AppData {
  // --- Meals ---
  static const List<Meal> meals = [
    // Breakfast
    Meal(
      id: 'breakfast1',
      title: 'Cashew Banana Pancakes',
      imagePath: 'assets/images/pancake.png',
      calories: '456 kcal',
      weight: 'Approx. 200g per serving',
      description: 'These Cashew Banana Pancakes are a delicious, healthy twist on the classic breakfast. Packed with natural sweetness from ripe bananas and healthy fats from cashews.',
      category: 'Breakfast',
      prepTime: '15 min',
    ),
    Meal(
      id: 'breakfast2',
      title: 'Avocado Egg Wrap',
      imagePath: 'assets/images/wrap.png',
      calories: '350 kcal',
      weight: 'Approx. 180g per serving',
      description: 'This Avocado Egg Wrap is a nutritious, protein-packed breakfast that will keep you full and focused.',
      category: 'Breakfast',
      prepTime: '15 min',
    ),
    Meal(
      id: 'breakfast3',
      title: 'Cucumber & Avocado Toast',
      imagePath: 'assets/images/toast.png',
      calories: '320 kcal',
      weight: 'Approx. 160g per serving',
      description: 'This fresh Cucumber and Avocado Toast is a light, refreshing, and incredibly nutritious breakfast option.',
      category: 'Breakfast',
      prepTime: '10 min',
    ),
    // Lunch
    Meal(
      id: 'lunch1',
      title: 'Grilled Chicken Salad',
      imagePath: 'assets/images/chickensalad.png',
      calories: '456 kcal',
      weight: 'Approx. 250g per serving',
      description: 'Tender grilled chicken breast served over crisp greens, cherry tomatoes, cucumbers, and light olive oil dressing.',
      category: 'Lunch',
      prepTime: '15 min',
    ),
    Meal(
      id: 'lunch2',
      title: 'Quinoa Salad with Avocado',
      imagePath: 'assets/images/avocadosalad.png',
      calories: '350 kcal',
      weight: 'Approx. 220g per serving',
      description: 'Nutrient-rich quinoa tossed with fresh avocado cubes, bell peppers, lemon vinaigrette, and toasted seeds.',
      category: 'Lunch',
      prepTime: '20 min',
    ),
    Meal(
      id: 'lunch3',
      title: 'Grilled Fish Tacos',
      imagePath: 'assets/images/fishtacos.png',
      calories: '400 kcal',
      weight: 'Approx. 230g per serving',
      description: 'Flaky seasoned fish wrapped in warm corn tortillas with shredded cabbage, lime juice, and avocado crema.',
      category: 'Lunch',
      prepTime: '25 min',
    ),
    // Dinner
    Meal(
      id: 'dinner1',
      title: 'Cheese Salad Bowl',
      imagePath: 'assets/images/cheese.png',
      calories: '450 kcal',
      weight: 'Approx. 240g per serving',
      description: 'Rich feta and mozzarella cheese paired with fresh leafy greens, black olives, and balsamic reduction.',
      category: 'Dinner',
      prepTime: '30 min',
    ),
    Meal(
      id: 'dinner2',
      title: 'Chicken with Sweet Potato',
      imagePath: 'assets/images/potato.png',
      calories: '500 kcal',
      weight: 'Approx. 300g per serving',
      description: 'Herb-roasted chicken breast paired with baked sweet potato wedges and steamed broccoli.',
      category: 'Dinner',
      prepTime: '40 min',
    ),
    Meal(
      id: 'dinner3',
      title: 'Salmon with Asparagus',
      imagePath: 'assets/images/salmon.png',
      calories: '550 kcal',
      weight: 'Approx. 280g per serving',
      description: 'Pan-seared Atlantic salmon fillet accompanied by garlic-roasted asparagus and lemon butter glaze.',
      category: 'Dinner',
      prepTime: '35 min',
    ),
  ];

  // --- Workouts ---
  static const List<Workout> workouts = [
    Workout(
      id: 'super_cardio',
      title: 'Super Cardio Burner',
      imagePath: 'assets/images/up.png',
      description: 'A high-intensity cardio workout...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'weight_loss',
      title: 'Weight Loss Plan',
      imagePath: 'assets/images/powerjump.png',
      description: 'A comprehensive plan to shed those extra pounds...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'balanced_fat',
      title: 'Balanced Fat Burn',
      imagePath: 'assets/images/complexcore.png',
      description: 'Burn fat while maintaining your lean muscle...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'endurance',
      title: 'Endurance Building',
      imagePath: 'assets/images/tabata.png',
      description: 'Build your stamina and endurance...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'lean_tone',
      title: 'Lean Tone',
      imagePath: 'assets/images/upperbody.png',
      description: 'Tone your muscles without getting bulky...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'strength',
      title: 'Strength Training',
      imagePath: 'assets/images/strength.png',
      description: 'Build raw strength and muscle mass...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'cardio',
      title: 'Cardio Blast',
      imagePath: 'assets/images/cardio.png',
      description: 'Improve your cardiovascular health...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'yoga',
      title: 'Yoga Routine',
      imagePath: 'assets/images/legrolling.png',
      description: 'Increase flexibility and mindfulness...',
      weeklyGoals: {},
    ),
    Workout(
      id: 'warmup',
      title: 'Warmup Exercises',
      imagePath: 'assets/images/warmup.png',
      description: 'Prepare your body for an intense workout...',
      weeklyGoals: {},
    ),
  ];

  // --- Exercises ---
  static const List<Exercise> exercises = [
    Exercise(
      id: 'crunches',
      title: 'Crunches',
      gifPath: 'assets/gifs/crunches.gif',
      instructions: [
        'Lie down on your back.',
        'Plant your feet on the floor, hip-width apart.',
        'Bend your knees and place your arms across your chest.',
        'Contract your abs and inhale.',
        'Exhale and lift your upper body, keeping your head and neck relaxed.',
        'Inhale and return to the starting position.'
      ],
    ),
    // We will add more exercises here
  ];
}
