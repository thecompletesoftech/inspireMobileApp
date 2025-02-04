import 'dart:convert';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_req_model.dart';
import 'package:public_housing/screens/special_amenities_screen/model/special_amenities_res_model.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

class SpecialAmenitiesController extends BaseController {
  var switchButton = false.obs;
  List<DeficiencyArea> deficiencyArea = [];
  List<SpecialAmenitiesResModel> specialAmenitiesDataList = [];
  List<SpecialAmenitiesReqModel> specialAmenitiesReq = [];
  TextEditingController disabilityController = TextEditingController();

  @override
  void onInit() {
    deficiencyArea = [];
    if (Get.arguments != null) {
      deficiencyArea = Get.arguments['deficiencyArea'];
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

    specialAmenitiesDataList.forEach(
      (element) {
        element.amenitiesList?.forEach(
          (e) {
            if ((e.isSelected ?? false) && e.title != null) {
              amenities.add(e.title ?? "");
            }
            if (e.titleType == 'switch') {
              e.title = disabilityController.text;
            }
          },
        );
        specialAmenitiesReq.add(
          SpecialAmenitiesReqModel(
            specialAmenities: SpecialAmenities(
              livingRoom: element.type == 'Living Room'
                  ? Amenities(name: element.type, amenities: amenities)
                  : null,
              overallCharacteristics: element.type == 'Overall Characteristics'
                  ? Amenities(name: element.type, amenities: amenities)
                  : null,
              otherRoomsUsedForLiving:
                  element.type == 'Other rooms used for living'
                      ? Amenities(name: element.type, amenities: amenities)
                      : null,
              kitchen: element.type == 'Kitchen'
                  ? Amenities(name: element.type, amenities: amenities)
                  : null,
              disabledAccessibility: element.type == 'Disabled Accessibility'
                  ? Amenities(name: element.type, amenities: amenities)
                  : null,
              bath: element.type == 'Bath'
                  ? Amenities(name: element.type, amenities: amenities)
                  : null,
            ),
          ),
        );
        amenities = [];
      },
    );
    print("specialAmenities--->${specialAmenitiesReq}");
    // Get.toNamed(InspectionUnitSummaryScreen.routes,
    //     arguments: {"deficiencyArea": deficiencyArea});
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
