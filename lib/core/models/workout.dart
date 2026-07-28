class Workout {
  final String id;
  final String title;
  final String imagePath;
  final String description;
  final Map<int, List<String>> weeklyGoals; // Week number to list of goals/exercises

  const Workout({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.weeklyGoals,
  });
}
