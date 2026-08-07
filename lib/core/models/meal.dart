class Meal {
  final String id;
  final String title;
  final String imagePath;
  final String calories;
  final String weight;
  final String description;
  final String category;
  final String prepTime;

  const Meal({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.calories,
    required this.weight,
    required this.description,
    this.category = 'Breakfast',
    this.prepTime = '15 min',
  });
}
