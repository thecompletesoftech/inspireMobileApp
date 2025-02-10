import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/screen/inspection_list_screen.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:public_housing/commons/all.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:public_housing/screens/deficiencies_inside_screen/Repository/deficiencies_inside_repository.dart';

enum ImageUploadStatus { initial, uploading, success }

class SignatureController extends BaseController {
  bool ownerSign = false;
  bool visibleBtn = false;
  bool tenantSign = false;
  bool isOwnerBlank = true;
  bool visibleBtn1 = false;
  bool isTenantBlank = true;
  GlobalKey<SfSignaturePadState> ownerSignPadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> tenantSignPadKey = GlobalKey();
  ScreenshotController ownerSignController = ScreenshotController();
  TextEditingController commentController = TextEditingController();
  ScreenshotController tenantSignController = ScreenshotController();
  ImageUploadStatus imageUploadStatus = ImageUploadStatus.initial;
  DeficienciesInsideRepository deficienciesInsideRepository =
      DeficienciesInsideRepository();
  String ownerSignature = '';
  String tenantSignature = '';
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();

  @override
  void onInit() {
    if (Get.arguments != null) {
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
    }
    super.onInit();
  }

  imageUpload({required String imagePath, required String signType}) async {
    imageUploadStatus = ImageUploadStatus.uploading;
    update();
    var response =
        await deficienciesInsideRepository.getImageUpload(filePath: imagePath);
    response.fold((l) {
      imageUploadStatus = ImageUploadStatus.initial;
      return null;
    }, (r) {
      if (signType == "tenant") {
        tenantSignature = r.images?.image ?? "";
      }
      if (signType == "owner") {
        ownerSignature = r.images?.image ?? "";
      }
      imageUploadStatus = ImageUploadStatus.success;
    });
    update();
  }

  createInspection() async {
    inspectionReqModel.inspection?.tenantSignature = tenantSignature;
    inspectionReqModel.inspection?.landlordSignature = ownerSignature;
    var response = await deficienciesInsideRepository.createInspection(
        inspectionModel: inspectionReqModel);

    response.fold(
      (l) {
        utils.showSnackBar(context: Get.context!, message: l.errorMessage);
      },
      (r) {
        tenantSignature = '';
        ownerSignature = '';
        inspectionReqModel = InspectionReqModel(
          inspection: Inspection(
            specialAmenities: SpecialAmenities(
              bath: Amenities(),
              disabledAccessibility: Amenities(),
              kitchen: Amenities(),
              livingRoom: Amenities(),
              otherRoomsUsedForLiving: Amenities(),
              overallCharacteristics: Amenities(),
            ),
          ),
          unit: Unit(),
          deficiencyInspections: [],
        );
        Get.offAllNamed(InspectionListScreen.routes);
      },
    );
    update();
  }
}
