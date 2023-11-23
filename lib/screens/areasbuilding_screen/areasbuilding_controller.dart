import 'package:public_housing/commons/all.dart';

import '../buildingdetails_screen/buildingdetails_controller.dart';

class AreasBuildingController extends BaseController {
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
  String? buildingTitle;
  bool visibleBtn = false;
  bool inComplete = false;

  var dataList = [
    RxCommonModel(
        title: "Access to the Building",
        subtitle:
            "Its main function is to provide safe and convenient access to the interior.It contains a door, with a lock to protect the privacy and security of the home.",
        image: ImagePath.door,
        status: "false",
        failMessage: "Inside"),
    RxCommonModel(
        title: "Building Exterior",
        subtitle:
            "The area surrounding the structure. Provides protection from the weather elements. It contains entry doors, windows for lighting and ventilation.",
        image: ImagePath.building,
        status: "false",
        failMessage: "Outside"),
    RxCommonModel(
        title: "Heating and Plumbing",
        subtitle:
            "The heating systems, such as boilers or radiators, which provide the necessary heat in winter. The plumbing infrastructure that guarantees a supply drinking water.",
        image: ImagePath.plumbing,
        status: "false",
        failMessage: "Inside"),
    RxCommonModel(
        title: "General Health and Safety",
        subtitle:
            "Contains first aid kits, fire extinguishers personal protective equipment, relevant information on evacuation procedures and emergency exits.",
        image: ImagePath.safety,
        status: "false",
        failMessage: "Inside"),
    RxCommonModel(
        title: "Special Amenities",
        subtitle:
            "Space designed to offer additional comforts. Can be an entertainment room with television and sound equipment, a games area, a swimming pool, or a gym.",
        image: ImagePath.amenities,
        status: "false",
        failMessage: "Inside - Outside"),
    RxCommonModel(
        title: "All Secondary Rooms",
        subtitle:
            "Rooms that include extra bedrooms, study rooms, play areas, or storage spaces. Each one is equipped with furniture and relevant elements for its specific use.",
        image: ImagePath.rooms,
        status: "false",
        failMessage: "Inside - Outside"),
  ];
  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (Get.isRegistered<BuildingDetailsController>()) {
        buildingTitle = Get.find<BuildingDetailsController>().propertyTitle ?? "";
      }
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  checkStatus() {
    var sum = 0;
    dataList.forEach((element) {
      if (element.status == "true") {
        sum++;
        inComplete = false;
      }
    });
    if (dataList.length == sum) {
      visibleBtn = true;
      update();
    }
  }
}
