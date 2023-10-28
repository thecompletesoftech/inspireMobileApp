import 'package:public_housing/commons/all.dart';

import '../auth/signing_screen/signing_screen.dart';

enum BuildingStatus { all, completed, inCompleted, scheduled }

class BuildingsController extends BaseController {
  var searchController = TextEditingController();
  int? currentSelection = 0;
  BuildingStatus status = BuildingStatus.all;
  bool change = false;
  int currentIndex = 1;
  RxCommonModel? item;

  RxList<RxCommonModel> dataList = [
    RxCommonModel(
        id: 1,
        title: "4 Units",
        subtitle: "Tenant",
        massage: "Buildings 1",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 2,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 2",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 3,
        title: "1 Units",
        subtitle: "Tenant",
        massage: "Buildings 3",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 4,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 4",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 5,
        title: "1 Units",
        subtitle: "Tenant",
        massage: "Buildings 5",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 6,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 6",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 7,
        title: "4 Units",
        subtitle: "Tenant",
        massage: "Buildings 7",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 8,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 8",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 9,
        title: "1 Units",
        subtitle: "Tenant",
        massage: "Buildings 9",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 10,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 10",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 11,
        title: "1 Units",
        subtitle: "Tenant",
        massage: "Buildings 11",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: BuildingStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 12,
        title: "2 Units",
        subtitle: "Tenant",
        massage: "Buildings 12",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: BuildingStatus.scheduled.toString(),
        check: false),
  ].obs;
  var searchList = [].obs;

  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();

  void actionPopUpItemSelected(int value) {
    // _scaffoldkey.currentState.hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar;
    String message;
    if (value == 0) {
      message = 'You selected ${Strings.editProfile}';
    } else if (value == 1) {
      message = 'You selected ${Strings.inspectionHistory}';
    } else if (value == 2) {
      message = 'You selected ${Strings.nSPIREStandards}';
    } else if (value == 3) {
      message = 'You selected ${Strings.logOut}';
      Get.offAllNamed(SigningScreen.routes);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    // _scaffoldkey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  @override
  onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      update();
    }
    searchItem("");
    super.onInit();
  }

  searchItem(str) {
    searchList.clear();
    if (utils.isValidationEmpty(str)) {
      searchList.addAll(dataList);
      update();
    } else {
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].title.toString().toLowerCase().contains(str.toString().toLowerCase())) {
          searchList.add(dataList[i]);
          update();
        }
      }
    }
    printAction(searchList.length.toString());
  }

  searchTypeItem() {
    searchList.clear();
    if (status.toString() == BuildingStatus.all.toString()) {
      searchList.addAll(dataList);
    } else {
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].status.toString() == status.toString()) {
          searchList.add(dataList[i]);
        }
      }
    }
  }

  /// ---- Get Home APi ----------->>>
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
}
