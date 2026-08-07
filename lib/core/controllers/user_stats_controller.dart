import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStatsController extends GetxController {
  var lastBmi = Rxn<double>();
  var lastTdee = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
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
