import 'package:get/get.dart';
import 'package:fit_fusion/core/routes/app_routes.dart';

import 'package:fit_fusion/SplashWrapper.dart';
import 'package:fit_fusion/features/auth/login.dart';
import 'package:fit_fusion/features/auth/signup.dart';
import 'package:fit_fusion/features/auth/doctor_login.dart';
import 'package:fit_fusion/features/auth/doctor_signup.dart';
import 'package:fit_fusion/features/auth/splashscreen.dart'; // assuming this exists
import 'package:fit_fusion/core/widgets/custom_navbar.dart';
import 'package:fit_fusion/features/doctor/pages/DoctorHomePage.dart';
import 'package:fit_fusion/features/doctor/pages/DoctorDetailPage.dart';
import 'package:fit_fusion/features/nutrition/nutrition_home.dart';
import 'package:fit_fusion/features/nutrition/dietplan.dart';
import 'package:fit_fusion/features/nutrition/Dietplan/breakfast1.dart';
import 'package:fit_fusion/features/nutrition/Dietplan/breakfast2.dart';
import 'package:fit_fusion/features/nutrition/Dietplan/breakfast3.dart';
import 'package:fit_fusion/features/profile/profile_settings_screen.dart';
import 'package:fit_fusion/features/workout/workout_home.dart';

import 'package:fit_fusion/features/workout/strength/Strength.dart';
import 'package:fit_fusion/features/workout/cardio/Cardio.dart';
import 'package:fit_fusion/features/workout/yoga/Yoga.dart';
import 'package:fit_fusion/features/workout/warmup/Warmup.dart';
import 'package:fit_fusion/features/workout/loseFat/Supercardio.dart';
import 'package:fit_fusion/features/workout/loseFat/WeightLose.dart';
import 'package:fit_fusion/features/workout/loseFat/Balancedfat.dart';
import 'package:fit_fusion/features/workout/loseFat/Endurance.dart';
import 'package:fit_fusion/features/workout/loseFat/leantone.dart';

import 'package:fit_fusion/features/workout/strength/Fullbody.dart';
import 'package:fit_fusion/features/workout/strength/Sixpack.dart';
import 'package:fit_fusion/features/workout/strength/StartExercise.dart';

import 'package:fit_fusion/utility/bmical.dart';
import 'package:fit_fusion/utility/fatcal.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashWrapper()),
    GetPage(name: AppRoutes.login, page: () {
      final email = Get.arguments as String?;
      return Login(email: email);
    }),
    GetPage(name: AppRoutes.signup, page: () => Signup()),
    GetPage(name: AppRoutes.navbar, page: () => Navbar()),
    GetPage(name: AppRoutes.doctorHome, page: () => DoctorHomePage()),
    GetPage(name: AppRoutes.doctorDetail, page: () => DoctorDetailPage(doctor: Get.arguments)),
    GetPage(name: AppRoutes.workoutHome, page: () => WorkoutHome()),
    GetPage(name: AppRoutes.dietPlan, page: () => Dietplan()),

    GetPage(name: AppRoutes.strength, page: () => Strength()),
    GetPage(name: AppRoutes.cardio, page: () => Cardio()),
    GetPage(name: AppRoutes.yoga, page: () => Yoga()),
    GetPage(name: AppRoutes.warmup, page: () => Warmup()),
    GetPage(name: AppRoutes.superCardio, page: () => Supercardio()),
    GetPage(name: AppRoutes.weightLose, page: () => WeightLose()),
    GetPage(name: AppRoutes.balancedFat, page: () => Balancedfat()),
    GetPage(name: AppRoutes.endurance, page: () => Endurance()),
    GetPage(name: AppRoutes.leanTone, page: () => leantone()),
    
    GetPage(name: AppRoutes.fullBody, page: () => Fullbody()),
    GetPage(name: AppRoutes.sixPack, page: () => Sixpack()),
    GetPage(name: AppRoutes.startExercise, page: () => StartExercise()),

    GetPage(name: AppRoutes.bmiCal, page: () => Bmical()),
    GetPage(name: AppRoutes.fatCal, page: () => Fatcal()),

    GetPage(name: AppRoutes.breakfast1, page: () => breakfast1()),
    GetPage(name: AppRoutes.breakfast2, page: () => breakfast2()),
    GetPage(name: AppRoutes.breakfast3, page: () => breakfast3()),
  ];
}
