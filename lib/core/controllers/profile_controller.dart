import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  var name = 'User'.obs;
  var email = 'user@example.com'.obs;
  var role = 'Patient'.obs;
  var gender = 'Male'.obs;
  var heightCm = 175.0.obs;
  var weightKg = 70.0.obs;
  var goal = 'Lose weight'.obs;
  var birthday = '01 Jan 1995'.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  double get bmi {
    if (heightCm.value <= 0) return 0.0;
    final heightInMeters = heightCm.value / 100.0;
    return weightKg.value / (heightInMeters * heightInMeters);
  }

  String get bmiCategory {
    final b = bmi;
    if (b < 18.5) return 'Underweight';
    if (b < 25.0) return 'Normal Weight';
    if (b < 30.0) return 'Overweight';
    return 'Obese';
  }

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        email.value = user.email ?? 'user@example.com';
        if (user.displayName != null && user.displayName!.isNotEmpty) {
          name.value = user.displayName!;
        }

        // Try fetching from Firebase Realtime DB
        final userSnap = await _dbRef.child('User').child(user.uid).get();
        if (userSnap.exists && userSnap.value is Map) {
          final data = Map<String, dynamic>.from(userSnap.value as Map);
          name.value = data['username'] ?? data['name'] ?? name.value;
          gender.value = data['gender'] ?? gender.value;
          heightCm.value = (data['height'] as num?)?.toDouble() ?? heightCm.value;
          weightKg.value = (data['weight'] as num?)?.toDouble() ?? weightKg.value;
          goal.value = data['goal'] ?? goal.value;
          birthday.value = data['birthday'] ?? birthday.value;
          role.value = 'Patient';
        } else {
          final docSnap = await _dbRef.child('Dietition').child(user.uid).get();
          if (docSnap.exists && docSnap.value is Map) {
            final data = Map<String, dynamic>.from(docSnap.value as Map);
            name.value = data['name'] ?? name.value;
            role.value = 'Dietitian';
          }
        }
      } else {
        // Load from local preferences if guest
        final prefs = await SharedPreferences.getInstance();
        name.value = prefs.getString('user_name') ?? 'Guest User';
        heightCm.value = prefs.getDouble('user_height') ?? 175.0;
        weightKg.value = prefs.getDouble('user_weight') ?? 70.0;
        goal.value = prefs.getString('user_goal') ?? 'Lose weight';
        gender.value = prefs.getString('user_gender') ?? 'Male';
      }
    } catch (e) {
      // Fallback
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveProfile({
    required String newName,
    required String newGender,
    required double newHeight,
    required double newWeight,
    required String newGoal,
    required String newBirthday,
  }) async {
    isLoading.value = true;
    try {
      name.value = newName;
      gender.value = newGender;
      heightCm.value = newHeight;
      weightKg.value = newWeight;
      goal.value = newGoal;
      birthday.value = newBirthday;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', newName);
      await prefs.setString('user_gender', newGender);
      await prefs.setDouble('user_height', newHeight);
      await prefs.setDouble('user_weight', newWeight);
      await prefs.setString('user_goal', newGoal);
      await prefs.setString('user_birthday', newBirthday);

      final user = _auth.currentUser;
      if (user != null) {
        final node = role.value == 'Dietitian' ? 'Dietition' : 'User';
        await _dbRef.child(node).child(user.uid).update({
          'username': newName,
          'name': newName,
          'gender': newGender,
          'height': newHeight,
          'weight': newWeight,
          'goal': newGoal,
          'birthday': newBirthday,
        });
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
