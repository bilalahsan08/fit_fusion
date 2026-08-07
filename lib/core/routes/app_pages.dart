import 'package:get/get.dart';
import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:fit_fusion/features/auth/splash_wrapper.dart';
import 'package:fit_fusion/features/auth/login.dart';
import 'package:fit_fusion/features/auth/signup.dart';
import 'package:fit_fusion/core/widgets/custom_navbar.dart';
import 'package:fit_fusion/features/doctor/pages/doctor_home_page.dart';
import 'package:fit_fusion/features/doctor/pages/doctor_detail_page.dart';
import 'package:fit_fusion/features/nutrition/dietplan.dart';
import 'package:fit_fusion/features/workout/workout_home.dart';
import 'package:fit_fusion/utility/bmi_cal.dart';
import 'package:fit_fusion/utility/fat_cal.dart';
import 'package:fit_fusion/utility/bmr_cal.dart';
import 'package:fit_fusion/utility/one_rep_max_cal.dart';
import 'package:fit_fusion/utility/ffmi_cal.dart';
import 'package:fit_fusion/utility/hydration_tracker.dart';

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

    GetPage(name: AppRoutes.bmiCal, page: () => Bmical()),
    GetPage(name: AppRoutes.fatCal, page: () => Fatcal()),
    GetPage(name: AppRoutes.bmrCal, page: () => const BmrCalScreen()),
    GetPage(name: AppRoutes.oneRepMax, page: () => const OneRepMaxScreen()),
    GetPage(name: AppRoutes.ffmiCal, page: () => const FfmiCalScreen()),
    GetPage(name: AppRoutes.hydration, page: () => const HydrationTrackerScreen()),
  ];
}
