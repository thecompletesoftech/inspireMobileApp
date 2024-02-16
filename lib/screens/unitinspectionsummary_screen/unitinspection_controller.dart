import 'package:flutter_svg/svg.dart';

import '../../commons/all.dart';

class UnitInspectionsummaryController extends BaseController {
  TextEditingController unitnumberoRname = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController unithousekeeping = TextEditingController();
  TextEditingController generalphysicalcondition = TextEditingController();
  final GlobalKey<PopupMenuButtonState<int>> popupKey1 = GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> popupKey2 = GlobalKey();
  List unithousekeepingList = [];
  List generalphysicalconditionList = [];
  List<String> cityList = [];
  String inspectionName = '';
  var dataList = [
    RxCommonModel(
      title: "D1. Cabinets are missing",
      status: "false",
      image: ImagePath.kitchen,
      imgId: ImagePath.cabinets,
    ),
    RxCommonModel(
      title: "D3. Refrigerator is missing",
      image: ImagePath.cooking,
      imgId: ImagePath.bedroom,
      status: "false",
    ),
  ];
  var switchbtn = false.obs;
  @override
  void onInit() {
    unithousekeepingList = [
      {
        "title": 'Poor',
        "value":
            "Damages to walls, hardware, doors, flooring, appliances beyond normal wear and tear."
      },
      {"title": 'Standards', "value": "No damage beyond normal wear and tear."},
      {"title": 'clean', "value": "No or minimal defect."}
    ];
    generalphysicalconditionList = [
      {
        "title": 'Poor',
        "value":
            "Damages to walls, hardware, doors, flooring, appliances beyond normal wear and tear."
      },
      {"title": 'Standards', "value": "No damage beyond normal wear and tear."},
      {"title": 'clean', "value": "No or minimal defect."}
    ];
    super.onInit();
  }

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
      // Get.offAllNamed(SigningScreen.routes);
      getStorageData.removeData(getStorageData.isLogin);
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void actionunitHousekeeping(value) {
    unithousekeeping.text = unithousekeepingList[value]['title'];
  }

  void actiongeneralphysical(value) {
    generalphysicalcondition.text =
        generalphysicalconditionList[value]['title'];
  }

  getUnitInspectionSummary() {
    return unitnumberoRname.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }
}
