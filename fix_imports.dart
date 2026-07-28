import 'dart:io';

void main() async {
  final file = File('lib/features/workout/workout_home.dart');
  final lines = await file.readAsLines();
  final newLines = lines.where((line) {
    if (line.contains("import 'package:fit_fusion/features/workout/")) {
      if (line.contains('workout_home') || line.contains('workout_program_screen')) {
        return true;
      }
      return false;
    }
    return true;
  }).toList();
  
  await file.writeAsString(newLines.join('\n'));
  print('Removed unused imports!');
}
