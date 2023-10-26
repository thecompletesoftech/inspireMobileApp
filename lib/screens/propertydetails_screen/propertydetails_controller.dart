import 'dart:async';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:screenshot/screenshot.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../main_screen/main_controller.dart';

class PropertyDetailsController extends BaseController {
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
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  final commentController = TextEditingController();
  final dateController = TextEditingController(text: "mm/dd/yyyy");

  List itemCount = [RxCommonModel(title: Strings.comment, subtitle: "05/21/2023")];

  final date1Controller = TextEditingController();

  bool tenantSign = false;
  bool ownerSign = false;
  GlobalKey<SfSignaturePadState> tenantSignPadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> ownerSignPadKey = GlobalKey();

  ScreenshotController tenantSignController = ScreenshotController();
  ScreenshotController ownerSignController = ScreenshotController();

  var dataList = [
    RxCommonModel(
      title: "D1. Cabinets are missing",
      status: "true",
      image: ImagePath.kitchen,
      imgId: ImagePath.cabinets,
    ),
    RxCommonModel(
      title: "D3. Refrigerator is missing",
      image: ImagePath.kitchen,
      imgId: ImagePath.bedroom,
      status: "false",
    ),
  ];
  String dropDownValue = "Roof Access Indicator*";
  List<String> itemList = ["Flat and Accessible"];
  final switcheleController = ValueNotifier<bool>(false);
  final switchgasController = ValueNotifier<bool>(false);
  final switchwatController = ValueNotifier<bool>(false);
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
    target: LatLng(37.42796133580664, 122.085749655962),
    zoom: 17,
  );
  SpeechToText speechToText = SpeechToText();
  var isListening = false.obs;
  var speechText = "".obs;

  void listen() async {
    var microphoneStatus = await Permission.microphone.status;
    var storageStatus = await Permission.storage.status;
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!storageStatus.isGranted) await Permission.storage.request();
    if (await Permission.microphone.isGranted) {
      if (!isListening.value) {
        bool available = await speechToText.initialize(
          onStatus: (val) {
            printAction("Permission onStatus $val");
            if (val == "done") {
              isListening.value = false;
              speechToText.stop();
              update();
            }
          },
          onError: (val) {
            printAction("Permission onError $val");
          },
        );
        if (available) {
          isListening.value = true;
          update();

          speechToText.listen(onResult: (val) {
            commentController.text = val.recognizedWords;
            update();
          });
        }
      } else {
        isListening.value = false;
        speechToText.stop();
        update();
      }
    } else {
      printAction("Permission Denied");
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      // item1 = Get.arguments[0];
      item = Get.arguments;
      if (item!.status == InspectionStatus.completed.toString() ||
          item!.status == InspectionStatus.inCompleted.toString()) {
        visibleBtn = false;
      } else {
        visibleBtn = false;
      }
      update();
    }
    checkPermission();

    // TODO: implement onInit
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

        if (status.isGranted && isEnableService) {
          printAction('Got permission and service enabled');
          processNext();
        } else {
          if (!isEnableService) {
            await Geolocator.requestPermission();
            // AppSettings.openLocationSettings();
          }
          printAction('have not got permission and service disabled');
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

    if (isEnableService) {
      if (status.isGranted) {
        processNext();
      }
    }
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
    Position latLng = await utils.determinePosition();
    userLocationLat = latLng.latitude;
    userLocationLng = latLng.longitude;
    kGooglePlex = CameraPosition(
      target: LatLng(userLocationLat!, userLocationLng!),
      zoom: 17,
    );
    update();
  }

  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  var formattedDate = ''.obs;

  Rx<DateTime> get selectedDate => _selectedDate;

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate.value,
      firstDate: DateTime(1985),
      lastDate: DateTime.now(),
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      var dateFormat = DateFormat("MM/dd/yyyy").format(selectedDate.value);
      formattedDate.value = dateFormat;
      dateController.text = dateFormat;
    }
    update();
  }

  void selectDate1() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate.value,
      firstDate: DateTime(1985),
      lastDate: DateTime.now(),
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      var dateFormat = DateFormat("MM/dd/yyyy").format(selectedDate.value);
      formattedDate.value = dateFormat;
      date1Controller.text = dateFormat;
    }
    update();
  }

  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  // GoogleMapController? mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylineWayPoint = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void onMapCreated(GoogleMapController controller) async {
    // mapController = controller;
    _customInfoWindowController.googleMapController = controller;

    setMarker();
    update();
  }

  setMarker() async {
    _customInfoWindowController.googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(userLocationLat!, userLocationLng!), zoom: 17),
    ));

    mapList.forEach((element) {
      _addMarker(element);
    });
    _getPolyline();
    update();
  }

  _addMarker(RxCommonModel element) async {
    MarkerId markerId = MarkerId(element.id.toString());
    Marker marker = Marker(
        markerId: markerId,
        icon: await utils.convertNetworkImageToCustomBitmapDescriptor("${element.id}",
            imageUrl: element.image!, titleBackgroundColor: appColors.appColor),
        // icon: BitmapDescriptor.fromBytes(await utils.getBytesFromAsset(element.image!, 70)),
        position: LatLng(element.lat!, element.lng!),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: appColors.white, borderRadius: BorderRadius.circular(8.px)),
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
                      ).paddingSymmetric(vertical: 16.px).paddingOnly(right: 24.px, left: 16.px),
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

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.googleApiKey,
        PointLatLng(mapList[0].lat!, mapList[0].lng!),
        PointLatLng(mapList[mapList.length - 1].lat!, mapList[mapList.length - 1].lng!),
        travelMode: TravelMode.driving,
        wayPoints: mapList.map((element) => PolylineWayPoint(location: "${element.lat!},${element.lng!}")).toList());
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      PolylineId id = PolylineId(mapList[0].title!);
      Polyline polyline = Polyline(polylineId: id, color: const Color(0xFF002D74), points: polylineCoordinates);
      polylines[id] = polyline;
      update();
    }
  }

  dialogInspectionInCompleted() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: Column(
          children: [
            Container(
              width: 312.px,
              // height: 184.px,
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
                          title: 'Stay',
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
                          title: 'Go back',
                          textColor: appColors.white,
                          color: appColors.appColor,
                          textSize: 16.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w500,
                          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                          radius: 100.px,
                          onTap: () {
                            Get.back();
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

  getFromCamera({int? index}) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();

    if (checkPermission) {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        imageFile = (pickedFile.path.obs);
        // visibleBtn = true;
        update();
      }
      update();
    }
  }

  getFromGallery({int? index}) async {
    bool checkPermission = await utils.checkPermissionOpenCamera();
    if (checkPermission) {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        imageFile = (pickedFile.path.obs);
        // visibleBtn = true;
        update();
      }
      update();
    }
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
