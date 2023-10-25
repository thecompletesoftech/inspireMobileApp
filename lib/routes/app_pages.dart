import 'package:get/get.dart';
import 'package:public_housing/screens/buildings_screen/buildings_binding.dart';

import '../screens/areas_screen/areas_binding.dart';
import '../screens/areas_screen/areas_screen.dart';
import '../screens/auth/signing_screen/signing_binding.dart';
import '../screens/auth/signing_screen/signing_screen.dart';
import '../screens/buildings_screen/buildings_screen.dart';
import '../screens/home_screen/home_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/inspection_screen/inspection_binding.dart';
import '../screens/inspection_screen/inspection_screen.dart';
import '../screens/inspection_summary_screen/inspection_summary_binding.dart';
import '../screens/inspection_summary_screen/inspection_summary_screen.dart';
import '../screens/kitchen_screen/kitchen_binding.dart';
import '../screens/kitchen_screen/kitchen_screen.dart';
import '../screens/main_screen/main_binding.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/noshow_screen/noshow_binding.dart';
import '../screens/noshow_screen/noshow_screen.dart';
import '../screens/progress_screen/progress_binding.dart';
import '../screens/progress_screen/progress_screen.dart';
import '../screens/property_screen/property_binding.dart';
import '../screens/property_screen/property_screen.dart';
import '../screens/propertydetails_screen/propertydetails_binding.dart';
import '../screens/propertydetails_screen/propertydetails_screen.dart';
import '../screens/signatures_screen/signature_binding.dart';
import '../screens/signatures_screen/signature_screen.dart';
import '../screens/splashscreen/splash_binding.dart';
import '../screens/splashscreen/splash_screen.dart';
import '../screens/standard_screen/standard_binding.dart';
import '../screens/standard_screen/standard_screen.dart';
import '../screens/text_message_screen/text_message_binding.dart';
import '../screens/text_message_screen/text_message_screen.dart';

class AppPages {
  static var list = [
    GetPage(name: SplashScreen.routes, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: MainScreen.routes, page: () => MainScreen(), binding: MainBinding()),
    GetPage(name: BuildingsScreen.routes, page: () => BuildingsScreen(), binding: BuildingsBinding()),
    GetPage(name: PropertyDetailsScreen.routes, page: () => PropertyDetailsScreen(), binding: PropertyDetailsBinding()),
    GetPage(name: PropertyScreen.routes, page: () => const PropertyScreen(), binding: PropertyBinding()),
    GetPage(name: HomeScreen.routes, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: InspectionScreen.routes, page: () => const InspectionScreen(), binding: InspectionBinding()),
    GetPage(name: NoShowScreen.routes, page: () => const NoShowScreen(), binding: NoShowBinding()),
    GetPage(name: TextMessageScreen.routes, page: () => TextMessageScreen(), binding: TextMessageBinding()),
    GetPage(name: AresScreen.routes, page: () => const AresScreen(), binding: AreasBinding()),
    GetPage(name: KitchenScreen.routes, page: () => const KitchenScreen(), binding: ItemDetailsBinding()),
    GetPage(name: StandardScreen.routes, page: () => const StandardScreen(), binding: StandardBinding()),
    GetPage(name: ProgressScreen.routes, page: () => const ProgressScreen(), binding: ProgressBinding()),
    GetPage(
        name: InspectionSummaryScreen.routes,
        page: () => const InspectionSummaryScreen(),
        binding: InspectionSummaryBinding()),
    GetPage(name: SignatureScreen.routes, page: () => const SignatureScreen(), binding: SignatureBinding()),
    GetPage(name: SigningScreen.routes, page: () => const SigningScreen(), binding: SigningBinding()),
  ];
}
