import 'dart:io';
import 'dart:convert';

void main() async {
  List<Map<String, dynamic>> meals = [];
  List<Map<String, dynamic>> workouts = [];

  final mealDir = Directory('lib/features/nutrition/diet_plan');
  if (await mealDir.exists()) {
    await for (var entity in mealDir.list()) {
      if (entity is File && entity.path.endsWith('.dart')) {
        meals.add(await extractFromFile(entity, 'meal'));
      }
    }
  }

  final workoutDirs = [
    'lib/features/workout/lose_fat',
    'lib/features/workout/strength',
    'lib/features/workout/cardio',
    'lib/features/workout/yoga',
    'lib/features/workout/warmup'
  ];

  for (var dirPath in workoutDirs) {
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await for (var entity in dir.list()) {
        if (entity is File && entity.path.endsWith('.dart') && !entity.path.contains('start_exercise')) {
          workouts.add(await extractFromFile(entity, 'workout'));
        }
      }
    }
  }

  print(jsonEncode({'meals': meals, 'workouts': workouts}));
}

Future<Map<String, dynamic>> extractFromFile(File file, String type) async {
  final content = await file.readAsString();
  final fileName = file.uri.pathSegments.last.replaceAll('.dart', '');

  // Extract image
  final imgMatch = RegExp(r"Image\.asset\(\s*['""]([^'""]+)['""]").firstMatch(content);
  final imagePath = imgMatch != null ? imgMatch.group(1)! : '';

  // Extract title
  var titleMatch = RegExp(r"Text\(\s*['""]([^'""]+)['""]\s*,\s*style:\s*GoogleFonts\.poppins\(\s*(?:fontSize:\s*(?:24|26|34)|fontWeight:\s*FontWeight\.bold)\)").firstMatch(content);
  if (titleMatch == null) {
    titleMatch = RegExp(r"Text\(\s*['""]([^'""]+)['""]\s*,\s*style:\s*GoogleFonts\.poppins\(\s*fontSize:\s*24\)").firstMatch(content);
  }
  final title = titleMatch != null ? titleMatch.group(1)! : '';

  if (type == 'meal') {
    final calMatch = RegExp(r"Calories:\s*([^\\]+?)(?:\\n|\s*kcal)").firstMatch(content);
    final calories = calMatch != null ? calMatch.group(1)!.trim() + " kcal" : '';

    final weightMatch = RegExp(r"Weight:\s*([^\\]+?)(?:\\n|"")").firstMatch(content);
    final weight = weightMatch != null ? weightMatch.group(1)!.trim() : '';

    final descMatch = RegExp(r"Text\(\s*['""](.*?)['""]\s*,\s*style:\s*GoogleFonts\.poppins\(fontSize:\s*16\)", dotAll: true).firstMatch(content);
    final desc = descMatch != null ? descMatch.group(1)!.replaceAll('\n', ' ').trim() : '';

    return {
      'id': fileName,
      'title': title,
      'imagePath': imagePath,
      'calories': calories,
      'weight': weight,
      'description': desc,
    };
  } else {
    final descMatch = RegExp(r"Text\(\s*['""](.*?)['""]\s*,\s*style:\s*GoogleFonts\.poppins\(fontSize:\s*16\)", dotAll: true).firstMatch(content);
    final desc = descMatch != null ? descMatch.group(1)!.replaceAll('\n', ' ').trim() : '';

    return {
      'id': fileName,
      'title': title,
      'imagePath': imagePath,
      'description': desc,
    };
  }
}
