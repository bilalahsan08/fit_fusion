import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStatsController extends GetxController {
  var lastBmi = Rxn<double>();
  var lastTdee = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    lastBmi.value = prefs.getDouble('last_bmi');
    lastTdee.value = prefs.getInt('last_tdee');
  }

  Future<void> saveBmi(double bmi) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('last_bmi', bmi);
    lastBmi.value = bmi;
  }

  Future<void> saveTdee(int tdee) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_tdee', tdee);
    lastTdee.value = tdee;
  }
}
