import 'package:public_housing/commons/all.dart';

class AreasController extends BaseController {
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
  bool change = true;

  var dataList = [
    RxCommonModel(
      title: "Access to the Unit",
      subtitle:
          "Its main function is to provide safe and convenient access to the interior.It contains a door, with a lock to protect the privacy and security of the home.",
      image: ImagePath.door,
      status: "false",
      // failMessage: "1 Failed Standards"
    ),
    RxCommonModel(
      title: "Living Room",
      subtitle:
          "A living room must contain sofas and chairs to sit on, a coffee table to support objects and possibly a television for entertainment.",
      image: ImagePath.livingRoom,
      status: "false",
    ),
    RxCommonModel(
      title: "Kitchen",
      subtitle:
          "A kitchen must contain an area to store, prepare, and cook food. A microwave is a substitute for a range, stove or oven to establish a kitchen.",
      image: ImagePath.kitchen,
      status: "false",
    ),
    RxCommonModel(
      title: "Bedroom",
      subtitle:
          "Must contains a comfortable and cozy bed to sleep in, as well as furniture such as wardrobes or chests of drawers to store clothes and personal belongings.",
      image: ImagePath.bedroom,
      status: "false",
    ),
    RxCommonModel(
      title: "Bathroom",
      subtitle:
          "Must contains a shower or bathtub for bathing, a sink for washing hands and brushing teeth, as well as a toilet for physiological needs.",
      image: ImagePath.bathroom,
      status: "false",
    ),
    RxCommonModel(
      title: "Building Exterior",
      subtitle:
          "The area surrounding the structure. Provides protection from the weather elements. It contains entry doors, windows for lighting and ventilation.",
      image: ImagePath.building,
      status: "false",
    ),
    RxCommonModel(
      title: "Heating and Plumbing",
      subtitle:
          "The heating systems, such as boilers or radiators, which provide the necessary heat in winter. the plumbing infrastructure that guarantees a supply drinking water.",
      image: ImagePath.plumbing,
      status: "false",
    ),
    RxCommonModel(
      title: "General Health and Safety",
      subtitle:
          "Contains first aid kits, fire extinguishers personal protective equipment, relevant information on evacuation procedures and emergency exits.",
      image: ImagePath.safety,
      status: "false",
    ),
    RxCommonModel(
      title: "Special Amenities",
      subtitle:
          "Space designed to offer additional comforts. Can be an entertainment room with television and sound equipment, a games area, a swimming pool, or a gym.",
      image: ImagePath.amenities,
      status: "false",
    ),
    RxCommonModel(
      title: "All Secondary Rooms",
      subtitle:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      image: ImagePath.rooms,
      status: "false",
    ),
  ];
  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments[1];
      item1 = Get.arguments[0];
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  checkStatus() {
    var sum = 0;
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].status == "true") {
        sum++;
      }
    }
    if (dataList.length == sum) {
      visibleBtn = true;
      update();
    }
  }
}
