import 'dart:io';

void main() async {
  final file = File('lib/features/workout/workout_home.dart');
  var content = await file.readAsString();

  content = content.replaceFirst("import 'package:fit_fusion/core/routes/app_routes.dart';", 
    "import 'package:fit_fusion/core/routes/app_routes.dart';\nimport 'package:fit_fusion/core/data/app_data.dart';\nimport 'package:fit_fusion/features/workout/pages/workout_program_screen.dart';");

  final mappings = {
    'AppRoutes.strength': "'strength'",
    'AppRoutes.cardio': "'cardio'",
    'AppRoutes.yoga': "'yoga'",
    'AppRoutes.warmup': "'warmup'",
    'AppRoutes.superCardio': "'super_cardio'",
    'AppRoutes.weightLose': "'weight_loss'",
    'AppRoutes.balancedFat': "'balanced_fat'",
    'AppRoutes.endurance': "'endurance'",
    'AppRoutes.leanTone': "'lean_tone'",
  };

  mappings.forEach((route, id) {
    content = content.replaceAll(
      "Get.toNamed($route)",
      "Get.to(() => WorkoutProgramScreen(workout: AppData.workouts.firstWhere((w) => w.id == $id)))"
    );
  });

  await file.writeAsString(content);
  print('Done refactoring workout_home.dart');
}
