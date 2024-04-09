import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/property_screen/property_controller.dart';

import '../auth/signing_screen/screen/signing_screen.dart';

enum BuildingStatus { all, completed, inCompleted, scheduled }

class BuildingsController extends BaseController {
  var searchController = TextEditingController();
  int? currentSelection = 0;
  BuildingStatus status = BuildingStatus.all;
  bool change = false;
  bool visibleBtn = false;
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

  bool? inComplete;

  void actionPopUpItemSelected(int value) {
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
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  @override
  onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (item!.status == PropertyStatus.completed.toString()) {
        dataList.forEach((element) {
          element.status = BuildingStatus.completed.toString();
        });
        inComplete = false;
        visibleBtn = true;
      } else {
        visibleBtn = false;
      }
      update();
    }
    searchItem("");
    super.onInit();
  }

  checkStatus() {
    var sum = 0;
    dataList.forEach((element) {
      if (element.status == BuildingStatus.completed.toString()) {
        sum++;
      }
    });
    if (dataList.length == sum) {
      inComplete = false;
      visibleBtn = true;
      update();
    }
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

  dialogInspectionInCompleted() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 312.px,
              padding: EdgeInsets.only(top: 24.px, left: 24.px, right: 24.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 24.px, height: 24.px, child: SvgPicture.string(icOops)),
                  MyTextView(
                    Strings.inspectionIncomplete,
                    textStyleNew: MyTextStyle(
                      textColor: appColors.textBlack,
                      textSize: 24.px,
                      textFamily: fontFamilyRegular,
                      textWeight: FontWeight.w400,
                    ),
                  ).paddingSymmetric(vertical: 16.px),
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'This inspection is still incomplete. Do you want to go back anyway?',
                            style: MyTextStyle(
                              textColor: appColors.lightText,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 312.px,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonButton(
                          title: Strings.cancel,
                          textColor: appColors.appColor,
                          color: appColors.transparent,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: Strings.backToProperties,
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back(closeOverlays: true);
                            Get.back(result: 1);
                          }),
                    ],
                  ).paddingOnly(
                    top: 24.px,
                    left: 8.px,
                    right: 24.px,
                    bottom: 24.px,
                  ),
                ],
              ),
            )
          ],
        ));
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
