import 'package:public_housing/commons/all.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../home_screen/home_controller.dart';

class SignatureController extends BaseController {
  /// ---- Get Inspection APi ----------->>>
  // getHome({var lat, lng}) async {
  //   FormData formData = FormData.fromMap({
  //     'user_id': getStorageData.readObject(getStorageData.userId),
  //     'curLat': lat ?? userLocationLat!,
  //     'curLng': lng ?? userLocationLng!,
  //   });
  //   if (filterBool.value && categorySelect.value != -1) {
  //     formData.fields.add(MapEntry(
  //         "cat_ids", categoryList[categorySelect.value].categories!.id!));
  //   }
  //   final data = await APIFunction().apiCall(
  //     context: Get.context!,
  //     apiName: Constants.getHome,
  //     params: formData,
  //     token: getStorageData.readObject(getStorageData.token),
  //   );
  //
  //   HomeModel model = HomeModel.fromJson(data);
  //   if (model.responseCode == 1) {
  //     if (model.data!.isNotEmpty) {
  //       homeModel = model.data!;
  //
  //       update();
  //     } else {}
  //     markerClass(lat: lat, lng: lng);
  //
  //     // utils.showSnackBar(context: Get.context!, message: model.responseMsg!,isOk: true);
  //
  //     update();
  //   } else if (model.responseCode == 0) {
  //     utils.showSnackBar(context: Get.context!, message: model.responseMsg!);
  //   }
  // }

  RxCommonModel? item;
  RxCommonModel? item1;
  bool visibleBtn = false;
  bool visibleBtn1 = false;
  final commentController = TextEditingController();
  bool tenantSign = false;
  bool ownerSign = false;
  GlobalKey<SfSignaturePadState> tenantSignPadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> ownerSignPadKey = GlobalKey();

  ScreenshotController tenantSignController = ScreenshotController();
  ScreenshotController ownerSignController = ScreenshotController();

  var sendImagesList = [];

  var isTenantBlank = true;
  var isOwnerBlank = true;

  String? itemTitle;

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (Get.isRegistered<HomeController>()) {
        itemTitle = Get.find<HomeController>().item!.massage!;
      }
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }
}
