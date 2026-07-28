import 'dart:io';

void main() async {
  final Map<String, String> moves = {
    'SplashWrapper.dart': 'features/auth/splash_wrapper.dart',
    'authentication/forgot_password.dart': 'features/auth/forgot_password.dart',
    'NotificationServices.dart': 'core/api/services/notification_services.dart',
    'core/api/ChatListPage.dart': 'features/chat/pages/chat_list_page.dart',

    'features/doctor/pages/DoctorChatlistPage.dart': 'features/doctor/pages/doctor_chat_list_page.dart',
    'features/doctor/pages/DoctorDetailPage.dart': 'features/doctor/pages/doctor_detail_page.dart',
    'features/doctor/pages/DoctorHomePage.dart': 'features/doctor/pages/doctor_home_page.dart',
    'features/doctor/pages/DoctorListPage.dart': 'features/doctor/pages/doctor_list_page.dart',
    'features/doctor/pages/DoctorProfile.dart': 'features/doctor/pages/doctor_profile.dart',
    'features/doctor/pages/DoctorRequestsPage.dart': 'features/doctor/pages/doctor_requests_page.dart',
    'features/doctor/widgets/DoctorCard.dart': 'features/doctor/widgets/doctor_card.dart',

    'features/workout/cardio/Cardio.dart': 'features/workout/cardio/cardio.dart',
    'features/workout/loseFat/Balancedfat.dart': 'features/workout/lose_fat/balanced_fat.dart',
    'features/workout/loseFat/Endurance.dart': 'features/workout/lose_fat/endurance.dart',
    'features/workout/loseFat/Supercardio.dart': 'features/workout/lose_fat/super_cardio.dart',
    'features/workout/loseFat/WeightLose.dart': 'features/workout/lose_fat/weight_lose.dart',
    'features/workout/loseFat/leantone.dart': 'features/workout/lose_fat/lean_tone.dart',

    'features/workout/strength/Fullbody.dart': 'features/workout/strength/full_body.dart',
    'features/workout/strength/Sixpack.dart': 'features/workout/strength/six_pack.dart',
    'features/workout/strength/StartExercise.dart': 'features/workout/strength/start_exercise.dart',
    'features/workout/strength/Strength.dart': 'features/workout/strength/strength.dart',

    'features/workout/strength/Exercise Details/Crunches.dart': 'features/workout/strength/exercise_details/crunches.dart',
    'features/workout/strength/Exercise Details/LegLifts.dart': 'features/workout/strength/exercise_details/leg_lifts.dart',
    'features/workout/strength/Exercise Details/SidePlankRaises.dart': 'features/workout/strength/exercise_details/side_plank_raises.dart',
    'features/workout/strength/Exercise Details/ToeTouches.dart': 'features/workout/strength/exercise_details/toe_touches.dart',

    'features/workout/warmup/Warmup.dart': 'features/workout/warmup/warmup.dart',
    'features/workout/yoga/Yoga.dart': 'features/workout/yoga/yoga.dart',

    'utility/bmical.dart': 'utility/bmi_cal.dart',
    'utility/fatcal.dart': 'utility/fat_cal.dart',

    'features/nutrition/Dietplan/breakfast1.dart': 'features/nutrition/diet_plan/breakfast1.dart',
    'features/nutrition/Dietplan/breakfast2.dart': 'features/nutrition/diet_plan/breakfast2.dart',
    'features/nutrition/Dietplan/breakfast3.dart': 'features/nutrition/diet_plan/breakfast3.dart',
  };

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('lib directory not found');
    return;
  }

  // Generate import mappings
  Map<String, String> importMappings = {};
  moves.forEach((oldPath, newPath) {
    String oldImport = 'package:fit_fusion/${oldPath.replaceAll('\\\\', '/')}';
    String newImport = 'package:fit_fusion/${newPath.replaceAll('\\\\', '/')}';
    importMappings[oldImport] = newImport;
  });

  // Step 1: Update all imports first while files are in their original location
  List<FileSystemEntity> allFiles = libDir.listSync(recursive: true);
  int updatedFiles = 0;
  for (var entity in allFiles) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = entity.readAsStringSync();
      bool changed = false;
      
      importMappings.forEach((oldImport, newImport) {
        if (content.contains(oldImport)) {
          content = content.replaceAll(oldImport, newImport);
          changed = true;
        }
      });
      
      if (changed) {
        entity.writeAsStringSync(content);
        updatedFiles++;
        print('Updated imports in: ${entity.path}');
      }
    }
  }
  print('Updated imports in $updatedFiles files.');

  // Step 2: Perform the moves using a temporary file to avoid Windows case-insensitivity deletion bugs
  for (var entry in moves.entries) {
    final oldFile = File('lib/${entry.key}');
    final newFile = File('lib/${entry.value}');
    final tmpFile = File('lib/${entry.key}.tmp');
    
    if (oldFile.existsSync()) {
      newFile.parent.createSync(recursive: true);
      
      // Copy to tmp
      final content = oldFile.readAsStringSync();
      tmpFile.writeAsStringSync(content);
      
      // Delete old file safely
      oldFile.deleteSync();
      
      // Write to new file from tmp
      final newContent = tmpFile.readAsStringSync();
      newFile.writeAsStringSync(newContent);
      
      // Delete tmp
      tmpFile.deleteSync();
      
      print('Moved: ${entry.key} -> ${entry.value}');
    } else {
      print('File not found: ${entry.key}');
    }
  }
  
  // Ignore deleting empty directories as it causes permissions errors on Windows sometimes
  print('Done!');
}
