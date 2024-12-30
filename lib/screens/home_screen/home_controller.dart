import 'dart:async';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import '../auth/signing_screen/screen/signing_screen.dart';
import '../buildings_screen/buildings_controller.dart';

enum InspectionStatus { all, completed, inCompleted, scheduled }

class HomeController extends BaseController {
  var searchController = TextEditingController();
  int? currentSelection = 0;
  InspectionStatus status = InspectionStatus.all;
  bool change = false;
  bool visibleBtn = false;
  int currentIndex = 1;

  RxList<RxCommonModel> dataList = [
    RxCommonModel(
        id: 1,
        title: "Fernando Devries",
        subtitle: "Tenant",
        massage: "A-1",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: InspectionStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 2,
        title: "Lori Bryson",
        subtitle: "Tenant",
        massage: "A-2",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: InspectionStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 3,
        title: "Lyle Koulfman",
        subtitle: "Tenant",
        massage: "B-1",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: InspectionStatus.scheduled.toString(),
        check: true),
    /* RxCommonModel(
        id: 4,
        title: "Fernando Devries",
        subtitle: "Tenant",
        massage: "B-2",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        status: InspectionStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 5,
        title: "Lori Bryson",
        subtitle: "Tenant",
        massage: "C-1",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        status: InspectionStatus.scheduled.toString(),
        check: false),
    RxCommonModel(
        id: 6,
        title: "Lyle Koulfman",
        subtitle: "Tenant",
        massage: "C-2",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        status: InspectionStatus.scheduled.toString(),
        check: true),*/
  ].obs;
  var searchList = [].obs;

  RxCommonModel? item;
  RxList<RxCommonModel> mapList = [
    RxCommonModel(
        id: 1,
        title: "Fernando Devries",
        subtitle: "Tenant",
        massage: "2113 Kendall Street",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        check: true,
        lat: 37.32589,
        lng: -122.026710),
    RxCommonModel(
        id: 2,
        title: "Lori Bryson",
        subtitle: "Tenant",
        massage: "2113 Martin",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        check: false,
        lat: 37.32293,
        lng: -122.02980),
    RxCommonModel(
        id: 3,
        title: "Lyle Koulfman",
        subtitle: "Tenant",
        massage: "1243 John M. Street",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        check: false,
        lat: 37.32108,
        lng: -122.03003),
    RxCommonModel(
        id: 4,
        title: "Fernando Devries",
        subtitle: "Tenant",
        massage: "2113 Kendall Street",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        check: true,
        lat: 37.32288,
        lng: -122.03523),
    RxCommonModel(
        id: 5,
        title: "Lori Bryson",
        subtitle: "Tenant",
        massage: "2113 Martin",
        image: ImagePath.pic2,
        imgId: ImagePath.media2,
        check: false,
        lat: 37.32526,
        lng: -122.03683),
    RxCommonModel(
        id: 6,
        title: "Lyle Koulfman",
        subtitle: "Tenant",
        massage: "1243 John M. Street",
        image: ImagePath.pic3,
        imgId: ImagePath.media3,
        check: false,
        lat: 37.32811,
        lng: -122.03689),
    RxCommonModel(
        id: 7,
        title: "Fernando Devries",
        subtitle: "Tenant",
        massage: "2113 Kendall Street",
        image: ImagePath.pic1,
        imgId: ImagePath.media1,
        check: true,
        lat: 37.32975,
        lng: -122.04033),
  ].obs;

  double? userLocationLat;
  double? userLocationLng;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  final GlobalKey<PopupMenuButtonState<int>> popupKey = GlobalKey();

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

  bool? inComplete;

  @override
  onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;

      if (item!.status == BuildingStatus.completed.toString()) {
        dataList.forEach((element) {
          element.status = BuildingStatus.completed.toString();
        });
        inComplete = false;
        visibleBtn = true;
      } else {
        visibleBtn = false;
      }
    }
    update();
    checkPermission();
    searchItem("");

    super.onInit();
  }

  Future<void> checkPermission() async {
    try {
      // You can request multiple permissions at once.
      var status = await Permission.location.status;
      printAction("status: $status");

      bool isEnableService = await locationPermission(isDoRequest: true);
      printAction("isEnableService: $isEnableService");

      if (!status.isGranted && !isEnableService) {
        // You can request multiple permissions at once.

        status = await Permission.location.request();
        printAction("status: $status");
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }

        isEnableService = await isLocationPermission(isDoRequest: true);
        printAction("isEnableService: $isEnableService");

        if (!isEnableService) {
          await Geolocator.requestPermission();
          // AppSettings.openLocationSettings();
        }

        if (status.isGranted && isEnableService) {
          printAction('Got permission and service enabled');
          processNext();
        }
      } else {
        processNext();
      }
    } catch (e) {
      printError("Error=====>$e");
    }
  }

  isLocationPermission({required bool isDoRequest}) async {
    var status = await Permission.location.status;

    bool isEnableService = await locationPermission();
    printAction("isEnableService: $isEnableService");
    return status;
  }

  Future<bool> locationPermission({bool isDoRequest = false}) async {
    Location location = Location();
    bool isEnableService1 = await location.serviceEnabled();
    if (isDoRequest && !isEnableService1) {
      printAction('test_current_location: isEnableService1 $isEnableService1');

      isEnableService1 = await location.requestService();
    }
    return isEnableService1;
  }

  Future<void> processNext() async {
    if (getStorageData.containKey(getStorageData.userLAT)) {
      printAction(
          "position----StorageLat->>${getStorageData.readString(getStorageData.userLAT)}");
      printAction(
          "position----StorageLng--->>${getStorageData.readString(getStorageData.userLNG)}");
      userLocationLat = getStorageData.readString(getStorageData.userLAT);
      userLocationLng = getStorageData.readString(getStorageData.userLNG);
    } else {
      Position latLng = await utils.determinePosition();

      getStorageData.saveString(getStorageData.userLAT, latLng.latitude);
      getStorageData.saveString(getStorageData.userLNG, latLng.longitude);
      printAction("position----lat->>${latLng.latitude}");
      printAction("position----lng--->>${latLng.longitude}");
      userLocationLat = latLng.latitude;
      userLocationLng = latLng.longitude;
    }
    kGooglePlex = CameraPosition(
      target: LatLng(userLocationLat!, userLocationLng!),
      zoom: 17,
    );
    update();
  }

  searchItem(str) {
    searchList.clear();
    if (utils.isValidationEmpty(str)) {
      searchList.addAll(dataList);
      update();
    } else {
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i]
            .title
            .toString()
            .toLowerCase()
            .contains(str.toString().toLowerCase())) {
          searchList.add(dataList[i]);
          update();
        }
      }
    }
    printAction(searchList.length.toString());
  }

  searchTypeItem() {
    searchList.clear();
    if (status.toString() == InspectionStatus.all.toString()) {
      searchList.addAll(dataList);
    } else {
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i].status.toString() == status.toString()) {
          searchList.add(dataList[i]);
        }
      }
    }
  }

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void onMapCreated(GoogleMapController controller) async {
    _customInfoWindowController.googleMapController = controller;
    setMarker();
    update();
  }

  setMarker() async {
    _customInfoWindowController.googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(userLocationLat!, userLocationLng!), zoom: 17),
    ));
    mapList.forEach((element) {
      _addMarker(element);
    });

    // _getPolyline();
    update();
  }

  _addMarker(RxCommonModel element) async {
    MarkerId markerId = MarkerId(element.id.toString());
    Marker marker = Marker(
        markerId: markerId,
        icon: await utils.convertNetworkImageToCustomBitmapDescriptor(
            "${element.id}",
            imageUrl: element.image!,
            titleBackgroundColor: appColors.appColor),
        position: LatLng(element.lat!, element.lng!),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.white,
                      borderRadius: BorderRadius.circular(8.px)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(
                            element.massage,
                            maxLinesNew: 1,
                            textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textWeight: FontWeight.w600,
                                textColor: appColors.black,
                                textFamily: fontFamilyRegular),
                          ).paddingOnly(bottom: 8.px),
                          MyTextView(
                            element.title,
                            maxLinesNew: 1,
                            textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textWeight: FontWeight.w400,
                                textColor: appColors.black,
                                textFamily: fontFamilyRegular),
                          ),
                        ],
                      )
                          .paddingSymmetric(vertical: 16.px)
                          .paddingOnly(right: 24.px, left: 16.px),
                      Image.asset(
                        element.imgId!,
                        width: 75.px,
                        fit: BoxFit.fill,
                        // height: 89.px,
                      ),
                    ],
                  ),
                ),
              ),
              Triangle.isosceles(
                edge: Edge.BOTTOM,
                child: Container(
                  color: Colors.white,
                  width: 20.0,
                  height: 10.0,
                ),
              ),
            ]),
            LatLng(element.lat!, element.lng!),
          );
        });
    markers[markerId] = marker;
    update();
  }

  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       Constants.googleApiKey,
  //       PointLatLng(mapList[0].lat!, mapList[0].lng!),
  //       PointLatLng(
  //           mapList[mapList.length - 1].lat!, mapList[mapList.length - 1].lng!),
  //       travelMode: TravelMode.driving,
  //       wayPoints: mapList
  //           .map((element) =>
  //               PolylineWayPoint(location: "${element.lat!},${element.lng!}"))
  //           .toList());
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //     PolylineId id = PolylineId(mapList[0].title!);
  //     Polyline polyline = Polyline(
  //         polylineId: id,
  //         color: const Color(0xFF002D74),
  //         points: polylineCoordinates);
  //     polylines[id] = polyline;
  //     update();
  //   }
  // }

  void navigateToMap() {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.px),
        ),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
                height: 500.px,
                child: Stack(
                  children: [
                    GetBuilder<HomeController>(builder: (_) {
                      return GoogleMap(
                        mapType: MapType.hybrid,
                        myLocationEnabled: true,
                        initialCameraPosition: kGooglePlex,
                        onMapCreated: onMapCreated,
                        markers: Set<Marker>.of(markers.values),
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        polylines: Set<Polyline>.of(polylines.values),
                      );
                    }),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 98,
                      width: 316,
                      // offset: 50,
                    ),
                  ],
                )),
            ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = mapList[index];
                  return ListTile(
                    isThreeLine: true,
                    onTap: () {
                      _customInfoWindowController.googleMapController!
                          .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: LatLng(item.lat!, item.lng!),
                                  zoom: 17)));
                    },
                    leading: CircleAvatar(
                      backgroundColor: appColors.appColor.withOpacity(0.8),
                      child: MyTextView(
                        "${index + 1}",
                        textStyleNew: MyTextStyle(
                            textSize: 16.px,
                            textWeight: FontWeight.w500,
                            textColor: appColors.white),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextView(
                          item.check == false
                              ? Strings.annualInspection
                              : Strings.tenant,
                          textStyleNew: MyTextStyle(
                            textSize: 12.px,
                            textWeight: FontWeight.w500,
                            textColor: appColors.textBlack2,
                          ),
                        ),
                        MyTextView(
                          item.massage.toString(),
                          textStyleNew: MyTextStyle(
                            textSize: 16.px,
                            textWeight: FontWeight.w400,
                            textColor: appColors.textBlack,
                          ),
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 12.px, horizontal: 16.px),
                    subtitle: MyTextView(
                      item.title.toString(),
                      textStyleNew: MyTextStyle(
                        textSize: 14.px,
                        textWeight: FontWeight.w400,
                        textColor: appColors.textBlack2,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTextView(
                          "08:00-10:00",
                          textStyleNew: MyTextStyle(
                            textSize: 11.px,
                            textWeight: FontWeight.w500,
                            textColor: appColors.textBlack2,
                          ),
                        ),
                        SizedBox(
                          width: 10.px,
                        ),
                        SvgPicture.string(
                          icTimeColor,
                          width: 24.px,
                          height: 24.px,
                        ),
                        // Image.asset(
                        //   ImagePath.icTimeColor,
                        //   height: 24.px,
                        //   width: 24.px,
                        // )
                      ],
                    ),
                    dense: true,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 2.px,
                    color: AppColors().divider,
                  );
                },
                itemCount: mapList.length),
          ],
        );
      },
    );
  }

  checkStatus() {
    var sum = 0;

    dataList.forEach((element) {
      if (element.status == InspectionStatus.completed.toString()) {
        sum++;
      }
    });
    if (dataList.length == sum) {
      inComplete = false;
      visibleBtn = true;
      update();
    }
    printAction(visibleBtn.toString());
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
                  SizedBox(
                      width: 24.px,
                      height: 24.px,
                      child: SvgPicture.string(icOops)),
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
                            text:
                                'This inspection is still incomplete. Do you want to go back anyway?',
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
                          }).paddingOnly(right: 8.px),
                      CommonButton(
                          title: Strings.backToInspections,
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.px, vertical: 10.px),
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

  @override
  void dispose() {
    popupKey.currentState!.deactivate();
    popupKey.currentState!.dispose();
    // TODO: implement dispose
    super.dispose();
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
