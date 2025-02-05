import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/inspection_list_screen/controller/inspection_list_controller.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_unit_summary_screen/screen/inspection_unit_summary_screen.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class SpecialAmenitiesController extends BaseController {
  var switchButton = false.obs;
  List<DeficiencyArea> deficiencyArea = [];
  List<SpecialAmenitiesResModel> specialAmenitiesDataList = [];
  List<SpecialAmenitiesReqModel> specialAmenitiesReq = [];
  TextEditingController disabilityController = TextEditingController();
  String unitAddress = '';
  String unitName = '';
  InspectionType inspectionType = InspectionType();
  Units unitData = Units();

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
      unitAddress = Get.arguments['unitAddress'];
      unitName = Get.arguments['unitName'];
      inspectionType = Get.arguments['inspectionType'];
    }
    if (Get.arguments['unitData'] != null) {
      unitData = Get.arguments['unitData'];
    }
    getSpecialAmenities();
    super.onInit();
  }

  getSpecialAmenities() async {
    var specialAmenitiesDecodeData = jsonDecode(specialAmenities.toString());

    if (specialAmenitiesDecodeData is List) {
      specialAmenitiesDecodeData.forEach((element) {
        specialAmenitiesDataList
            .add(SpecialAmenitiesResModel.fromJson(element));
      });
    } else {
      print(
          'Expected a List but got: ${specialAmenitiesDecodeData.runtimeType}');
    }
    update();
  }

  inspectionSummaryOnTap() {
    specialAmenitiesReq.clear();

    List<String> amenities = [];
    SpecialAmenities singleSpecialAmenities = SpecialAmenities();

    specialAmenitiesDataList.forEach(
      (element) {
        element.amenitiesList?.forEach(
          (e) {
            if (e.titleType == 'switch') {
              e.title = disabilityController.text;
            }
            if ((e.isSelected ?? false) && e.title != null) {
              amenities.add(e.title ?? "");
            }
          },
        );
        if (amenities.isNotEmpty) {
          if (element.type == 'Living Room') {
            singleSpecialAmenities.livingRoom =
                Amenities(name: element.type, amenities: amenities);
          } else if (element.type == 'Overall Characteristics') {
            singleSpecialAmenities.overallCharacteristics =
                Amenities(name: element.type, amenities: amenities);
          } else if (element.type == 'Other rooms used for living') {
            singleSpecialAmenities.otherRoomsUsedForLiving =
                Amenities(name: element.type, amenities: amenities);
          } else if (element.type == 'Kitchen') {
            singleSpecialAmenities.kitchen =
                Amenities(name: element.type, amenities: amenities);
          } else if (element.type == 'Disabled Accessibility') {
            singleSpecialAmenities.disabledAccessibility =
                Amenities(name: element.type, amenities: amenities);
          } else if (element.type == 'Bath') {
            singleSpecialAmenities.bath =
                Amenities(name: element.type, amenities: amenities);
          }
        }
        amenities = [];
      },
    );
    if (singleSpecialAmenities.livingRoom != null ||
        singleSpecialAmenities.overallCharacteristics != null ||
        singleSpecialAmenities.otherRoomsUsedForLiving != null ||
        singleSpecialAmenities.kitchen != null ||
        singleSpecialAmenities.disabledAccessibility != null ||
        singleSpecialAmenities.bath != null) {
      specialAmenitiesReq.add(
          SpecialAmenitiesReqModel(specialAmenities: singleSpecialAmenities));
    }

    if (specialAmenitiesReq.isNotEmpty) {
      inspectionReqModel.inspection?.specialAmenities =
          specialAmenitiesReq.first.specialAmenities;
    }

    Get.toNamed(InspectionUnitSummaryScreen.routes, arguments: {
      "deficiencyArea": deficiencyArea,
      "unitAddress": unitAddress,
      "unitName": unitName,
      "inspectionType": inspectionType,
      "unitData": unitData,
    });
  }
}

var specialAmenities = '''
[
  {
    "type": "Living Room",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "High quality floors or wall coverings",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Working fireplace or stove",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Balcony, patio, deck, porch",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Special windows or doors",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Exceptional size relative to needs of family",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "",
        "titleType": "textfield"
      }
    ]
  },
  {
    "type": "Kitchen",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "Dishwasher",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Separate freezer",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Garbage disposal",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Eating counter/breakfast nook",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Double oven/self cleaning oven, microwave",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Double sink",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "High quality cabinets",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Abundant counter-top space",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Modern appliance(s)",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Exceptional size relative to needs of family",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "",
        "titleType": "textfield"
      }
    ]
  },
  {
    "type": "Other rooms used for living",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "High quality floors or wall coverings",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Working fireplace or stove",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Balcony, patio, deck, porch",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Special windows or doors",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Exceptional size relative to needs of family",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "",
        "titleType": "textfield"
      }
    ]
  },
  {
    "type": "Bath",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "Special feature shower head",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Built-in heat lamp",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Large mirrors",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Glass door on shower/tub",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Separate dressing room",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Double sink or special lavatory",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Exceptional size relative to needs of family",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "",
        "titleType": "textfield"
      }
    ]
  },
  {
    "type": "Overall Characteristics",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "Storm windows and doors",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Other forms of weatherization (e.g., insulation, weather, stripping)",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Screen doors or windows",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Good upkeep of grounds (i.e., site cleanliness, landscaping)",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Garage",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Parking Facilities",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Driveway",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Large yard",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Good maintenance of building exterior",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Wall A/C",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "Central A/C",
        "titleType": "text"
      },
      {
        "isSelected": false,
        "title": "",
        "titleType": "textfield"
      }
    ]
  },
  {
    "type": "Disabled Accessibility",
    "amenitiesList": [
      {
        "isSelected": false,
        "title": "Unit is accessible to a particular disability: ",
        "titleType": "switch"
      }
    ]
  }
]
''';
