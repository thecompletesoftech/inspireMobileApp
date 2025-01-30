import 'package:get/get.dart';
import 'package:public_housing/screens/authority_signatures_screen/authority_signature_screen.dart';
import 'package:public_housing/screens/building_cabinets_screen/binding/standards_details_binding.dart';
import 'package:public_housing/screens/building_cabinets_screen/screen/standards_details_screen.dart';
import 'package:public_housing/screens/building_inspection_screen/binding/building_inspection_binding.dart';
import 'package:public_housing/screens/building_inspection_screen/screen/building_inspection_screen.dart';
import 'package:public_housing/screens/building_inspection_summary/binding/building_inspection_summary_binding.dart';
import 'package:public_housing/screens/building_inspection_summary/screen/building_inspection_summary_screen.dart';
import 'package:public_housing/screens/building_list_screen/binding/building_list_binding.dart';
import 'package:public_housing/screens/building_list_screen/screen/building_list_screen.dart';
import 'package:public_housing/screens/building_standards_screen/binding/building_standards_binding.dart';
import 'package:public_housing/screens/building_standards_screen/screen/building_standards_screen.dart';
import 'package:public_housing/screens/buildings_screen/buildings_binding.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/bindings/deficiencies_inside_binding.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/screen/deficiencies_inside_screen.dart';
import 'package:public_housing/screens/inspection_cabinets_screen/binding/inspection_standards_details_binding.dart';
import 'package:public_housing/screens/inspection_cabinets_screen/screen/inspection_standards_details_screen.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/bindings/inspection_deficiencies_inside_binding.dart';
import 'package:public_housing/screens/inspection_deficiencies_inside_screen/screen/inspection_deficiencies_inside_screen.dart';
import 'package:public_housing/screens/inspection_information_screen/binding/inspection_information_binding.dart';
import 'package:public_housing/screens/inspection_information_screen/screen/inspection_information_screen.dart';
import 'package:public_housing/screens/inspection_list_screen/binding/inspection_list_binding.dart';
import 'package:public_housing/screens/inspection_list_screen/screen/inspection_list_screen.dart';
import 'package:public_housing/screens/inspection_standards_screen/binding/inspection_standards_binding.dart';
import 'package:public_housing/screens/inspection_standards_screen/screen/inspection_standards_screen.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/binding/inspection_unit_summary_binding.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/screen/inspection_unit_summary_screen.dart';
import 'package:public_housing/screens/no_show_screen/binding/no_show_binding.dart';
import 'package:public_housing/screens/no_show_screen/screen/no_show_screen.dart';
import 'package:public_housing/screens/properties_list_screen/binding/properties_list_binding.dart';
import 'package:public_housing/screens/properties_list_screen/screen/properties_list_screen.dart';
import 'package:public_housing/screens/select_work_screen/binding/select_work_binding.dart';
import 'package:public_housing/screens/select_work_screen/screen/select_work_screen.dart';
import 'package:public_housing/screens/special_amenities_screen/binding/special_amenities_binding.dart';
import 'package:public_housing/screens/special_amenities_screen/screen/special_amenities_screen.dart';
import 'package:public_housing/screens/unit_inspection_screen/binding/unit_inspection_binding.dart';
import 'package:public_housing/screens/unit_inspection_screen/screen/unit_inspection_screen.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/binding/unit_inspection_binding.dart';
import 'package:public_housing/screens/unit_inspection_summary_screen/screen/unit_inspection_summary_screen.dart';
import 'package:public_housing/screens/unit_list_screen/binding/unit_list_binding.dart';
import 'package:public_housing/screens/unit_list_screen/screen/unit_list_screen.dart';
import '../screens/unit_building_standards_screen/binding/unit_building_standards_binding.dart';
import '../screens/unit_building_standards_screen/screen/unit_building_standards_screen.dart';
import '../screens/unit_deficiencies_inside_screen/bindings/unit_deficiencies_inside_binding.dart';
import '../screens/unit_deficiencies_inside_screen/screen/unit_deficiencies_inside_screen.dart';
import '../screens/areas_screen/areas_binding.dart';
import '../screens/areas_screen/areas_screen.dart';
import '../screens/areasbuilding_screen/areasbuilding_binding.dart';
import '../screens/areasbuilding_screen/areasbuilding_screen.dart';
import '../screens/auth/signing_screen/binding/signing_binding.dart';
import '../screens/auth/signing_screen/screen/signing_screen.dart';
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
import '../screens/pdf_screen/pdf_binding.dart';
import '../screens/pdf_screen/pdf_screen.dart';
import '../screens/progress_screen/progress_binding.dart';
import '../screens/progress_screen/progress_screen.dart';
import '../screens/property_screen/property_binding.dart';
import '../screens/property_screen/property_screen.dart';
import '../screens/propertydetails_screen/propertydetails_binding.dart';
import '../screens/propertydetails_screen/propertydetails_screen.dart';
import '../screens/signatures_screen/binding/signature_binding.dart';
import '../screens/signatures_screen/screen/signature_screen.dart';
import '../screens/splashscreen/binding/splash_binding.dart';
import '../screens/splashscreen/screen/splash_screen.dart';
import '../screens/standard_screen/standard_binding.dart';
import '../screens/standard_screen/standard_screen.dart';
import '../screens/text_message_screen/text_message_binding.dart';
import '../screens/text_message_screen/text_message_screen.dart';
import '../screens/unit_cabinets_screen /binding/unit_standards_details_binding.dart';
import '../screens/unit_cabinets_screen /screen/unit_standards_details_screen.dart';

class AppPages {
  static var list = [
    GetPage(
        name: SplashScreen.routes,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: PropertyScreen.routes,
        page: () => PropertyScreen(),
        binding: PropertyBinding()),
    GetPage(
        name: BuildingsScreen.routes,
        page: () => BuildingsScreen(),
        binding: BuildingsBinding()),
    GetPage(
        name: PropertyDetailsScreen.routes,
        page: () => PropertyDetailsScreen(),
        binding: PropertyDetailsBinding()),
    GetPage(
        name: BuildingInspectionScreen.routes,
        page: () => const BuildingInspectionScreen(),
        binding: BuildingInspectionBinding()),
    GetPage(
        name: BuildingStandardsScreen.routes,
        page: () => const BuildingStandardsScreen(),
        binding: BuildingStandardsBinding()),
    GetPage(
        name: StandardsDetailsScreen.routes,
        page: () => const StandardsDetailsScreen(),
        binding: StandardsDetailsBinding()),
    GetPage(
        name: DeficienciesInsideScreen.routes,
        page: () => const DeficienciesInsideScreen(),
        binding: DeficienciesInsideBinding()),
    GetPage(
        name: BuildingInspectionSummaryScreen.routes,
        page: () => const BuildingInspectionSummaryScreen(),
        binding: BuildingInspectionSummaryBinding()),
    GetPage(
        name: BuildingDetailsScreen.routes,
        page: () => const BuildingDetailsScreen(),
        binding: BuildingDetailsBinding()),
    GetPage(
        name: CertificatesScreen.routes,
        page: () => const CertificatesScreen(),
        binding: CertificatesBinding()),
    GetPage(
        name: DeficienciesFoundScreen.routes,
        page: () => const DeficienciesFoundScreen(),
        binding: DeficienciesFoundBinding()),
    GetPage(
        name: AresBuildingScreen.routes,
        page: () => const AresBuildingScreen(),
        binding: AreasBuildingBinding()),
    GetPage(
        name: BuildingExteriorScreen.routes,
        page: () => const BuildingExteriorScreen(),
        binding: BuildingExteriorBinding()),
    GetPage(
        name: PdfScreen.routes,
        page: () => const PdfScreen(),
        binding: PdfBinding()),
    GetPage(
        name: HSAckScreen.routes,
        page: () => const HSAckScreen(),
        binding: HSAckBinding()),
    GetPage(
        name: AuthoritySignatureScreen.routes,
        page: () => const AuthoritySignatureScreen(),
        binding: AuthoritySignatureBinding()),
    GetPage(
        name: HomeScreen.routes,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: InspectionScreen.routes,
        page: () => const InspectionScreen(),
        binding: InspectionBinding()),
    GetPage(
        name: NoShowScreen.routes,
        page: () => const NoShowScreen(),
        binding: NoShowBinding()),
    GetPage(
        name: TextMessageScreen.routes,
        page: () => TextMessageScreen(),
        binding: TextMessageBinding()),
    GetPage(
        name: AresScreen.routes,
        page: () => const AresScreen(),
        binding: AreasBinding()),
    GetPage(
        name: KitchenScreen.routes,
        page: () => const KitchenScreen(),
        binding: ItemDetailsBinding()),
    GetPage(
        name: StandardScreen.routes,
        page: () => const StandardScreen(),
        binding: StandardBinding()),
    GetPage(
        name: ProgressScreen.routes,
        page: () => const ProgressScreen(),
        binding: ProgressBinding()),
    GetPage(
        name: InspectionSummaryScreen.routes,
        page: () => const InspectionSummaryScreen(),
        binding: InspectionSummaryBinding()),
    GetPage(
        name: SignatureScreen.routes,
        page: () => const SignatureScreen(),
        binding: SignatureBinding()),
    GetPage(
        name: SigningScreen.routes,
        page: () => const SigningScreen(),
        binding: SigningBinding()),
    GetPage(
        name: UnitInspection.routes,
        page: () => const UnitInspection(),
        binding: UnitInspectionBinding()),
    GetPage(
        name: UnitInspectionSummary.routes,
        page: () => const UnitInspectionSummary(),
        binding: UnitInspectionSummaryBinding()),
    GetPage(
        name: UnitBuildingStandardsScreen.routes,
        page: () => UnitBuildingStandardsScreen(),
        binding: UnitBuildingStandardsBinding()),
    GetPage(
        name: UnitStandardsDetailsScreen.routes,
        page: () => UnitStandardsDetailsScreen(),
        binding: UnitStandardsDetailsBinding()),
    GetPage(
        name: UnitDeficienciesInsideScreen.routes,
        page: () => UnitDeficienciesInsideScreen(),
        binding: UnitDeficienciesInsideBinding()),
    GetPage(
        name: PropertiesListScreen.routes,
        page: () => PropertiesListScreen(),
        binding: PropertiesListBinding()),
    GetPage(
        name: BuildingListScreen.routes,
        page: () => BuildingListScreen(),
        binding: BuildingListBinding()),
    GetPage(
        name: SelectWorkScreen.routes,
        page: () => SelectWorkScreen(),
        binding: SelectWorkBinding()),
    GetPage(
        name: UnitListScreen.routes,
        page: () => UnitListScreen(),
        binding: UnitListBinding()),
    GetPage(
        name: InspectionListScreen.routes,
        page: () => InspectionListScreen(),
        binding: InspectionListBinding()),
    GetPage(
        name: InspectionInformationScreen.routes,
        page: () => InspectionInformationScreen(),
        binding: InspectionInformationBinding()),
    GetPage(
        name: InspectionStandardsScreen.routes,
        page: () => InspectionStandardsScreen(),
        binding: InspectionStandardsBinding()),
    GetPage(
        name: InspectionStandardsDetailsScreen.routes,
        page: () => InspectionStandardsDetailsScreen(),
        binding: InspectionStandardsDetailsBinding()),
    GetPage(
        name: InspectionDeficienciesInsideScreen.routes,
        page: () => InspectionDeficienciesInsideScreen(),
        binding: InspectionDeficienciesInsideBinding()),
    GetPage(
        name: SpecialAmenitiesScreen.routes,
        page: () => SpecialAmenitiesScreen(),
        binding: SpecialAmenitiesBinding()),
    GetPage(
        name: InspectionUnitSummaryScreen.routes,
        page: () => InspectionUnitSummaryScreen(),
        binding: InspectionUnitSummaryBinding()),
  ];
}
