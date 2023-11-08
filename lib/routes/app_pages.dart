import 'package:get/get.dart';
import 'package:public_housing/screens/authority_signatures_screen/authority_signature_screen.dart';
import 'package:public_housing/screens/buildings_screen/buildings_binding.dart';

import '../screens/areas_screen/areas_binding.dart';
import '../screens/areas_screen/areas_screen.dart';
import '../screens/areasbuilding_screen/areasbuilding_binding.dart';
import '../screens/areasbuilding_screen/areasbuilding_screen.dart';
import '../screens/auth/signing_screen/signing_binding.dart';
import '../screens/auth/signing_screen/signing_screen.dart';
import '../screens/authority_signatures_screen/authority_signature_binding.dart';
import '../screens/building_exterior_screen/building_exterior_binding.dart';
import '../screens/building_exterior_screen/building_exterior_screen.dart';
import '../screens/buildingdetails_screen/buildingdetails_binding.dart';
import '../screens/buildingdetails_screen/buildingdetails_screen.dart';
import '../screens/buildings_screen/buildings_screen.dart';
import '../screens/certificates_screen/certificates_binding.dart';
import '../screens/certificates_screen/certificates_screen.dart';
import '../screens/deficiencies_found_screen/deficiencies_found_binding.dart';
import '../screens/deficiencies_found_screen/deficiencies_found_screen.dart';
import '../screens/home_screen/home_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/hs_ack_screen/hs_ack_binding.dart';
import '../screens/hs_ack_screen/hs_ack_screen.dart';
import '../screens/inspection_screen/inspection_binding.dart';
import '../screens/inspection_screen/inspection_screen.dart';
import '../screens/inspection_summary_screen/inspection_summary_binding.dart';
import '../screens/inspection_summary_screen/inspection_summary_screen.dart';
import '../screens/kitchen_screen/kitchen_binding.dart';
import '../screens/kitchen_screen/kitchen_screen.dart';
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
    GetPage(name: PropertyScreen.routes, page: () => PropertyScreen(), binding: PropertyBinding()),
    GetPage(name: BuildingsScreen.routes, page: () => BuildingsScreen(), binding: BuildingsBinding()),
    GetPage(name: PropertyDetailsScreen.routes, page: () => PropertyDetailsScreen(), binding: PropertyDetailsBinding()),
    GetPage(
        name: BuildingDetailsScreen.routes,
        page: () => const BuildingDetailsScreen(),
        binding: BuildingDetailsBinding()),
    GetPage(name: CertificatesScreen.routes, page: () => const CertificatesScreen(), binding: CertificatesBinding()),
    GetPage(
        name: DeficienciesFoundScreen.routes,
        page: () => const DeficienciesFoundScreen(),
        binding: DeficienciesFoundBinding()),
    GetPage(name: AresBuildingScreen.routes, page: () => const AresBuildingScreen(), binding: AreasBuildingBinding()),
    GetPage(
        name: BuildingExteriorScreen.routes,
        page: () => const BuildingExteriorScreen(),
        binding: BuildingExteriorBinding()),
    GetPage(name: HSAckScreen.routes, page: () => const HSAckScreen(), binding: HSAckBinding()),
    GetPage(
        name: AuthoritySignatureScreen.routes,
        page: () => const AuthoritySignatureScreen(),
        binding: AuthoritySignatureBinding()),
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
