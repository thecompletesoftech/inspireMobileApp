// // To parse this JSON data, do
// //
// //     final dailySchedulesResponseModel = dailySchedulesResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// DailySchedulesResponseModel dailySchedulesResponseModelFromJson(String str) =>
//     DailySchedulesResponseModel.fromJson(json.decode(str));
//
// String dailySchedulesResponseModelToJson(DailySchedulesResponseModel data) =>
//     json.encode(data.toJson());
//
// class DailySchedulesResponseModel {
//   String? type;
//   List<ScheduleDatum>? scheduleData;
//
//   DailySchedulesResponseModel({
//     this.type,
//     this.scheduleData,
//   });
//
//   factory DailySchedulesResponseModel.fromJson(Map<String, dynamic> json) =>
//       DailySchedulesResponseModel(
//         type: json["type"],
//         scheduleData: json["schedule_data"] == null
//             ? []
//             : List<ScheduleDatum>.from(
//                 json["schedule_data"]!.map((x) => ScheduleDatum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "schedule_data": scheduleData == null
//             ? []
//             : List<dynamic>.from(scheduleData!.map((x) => x.toJson())),
//       };
// }
//
// class ScheduleDatum {
//   String? state;
//   String? zip;
//   String? city;
//   DateTime? date;
//   String? property;
//   Building? building;
//
//   ScheduleDatum({
//     this.state,
//     this.zip,
//     this.city,
//     this.date,
//     this.property,
//     this.building,
//   });
//
//   factory ScheduleDatum.fromJson(Map<String, dynamic> json) => ScheduleDatum(
//         state: json["State"],
//         zip: json["Zip"],
//         city: json["City"],
//         date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
//         property: json["Property"],
//         building: json["building"] == null
//             ? null
//             : Building.fromJson(json["building"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "State": state,
//         "Zip": zip,
//         "City": city,
//         "Date":
//             "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "Property": property,
//         "building": building?.toJson(),
//       };
// }
//
// class Building {
//   String? buildingName;
//   String? buildingType;
//   String? year;
//   bool? iscompleted;
//   String? id;
//   List<Unit>? units;
//
//   Building({
//     this.buildingName,
//     this.buildingType,
//     this.year,
//     this.iscompleted,
//     this.id,
//     this.units,
//   });
//
//   factory Building.fromJson(Map<String, dynamic> json) => Building(
//         buildingName: json["building_name"],
//         buildingType: json["building_type"],
//         year: json["year"],
//         iscompleted: json["iscompleted"],
//         id: json["id"],
//         units: json["Units"] == null
//             ? []
//             : List<Unit>.from(json["Units"]!.map((x) => Unit.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "building_name": buildingName,
//         "building_type": buildingType,
//         "year": year,
//         "iscompleted": iscompleted,
//         "id": id,
//         "Units": units == null
//             ? []
//             : List<dynamic>.from(units!.map((x) => x.toJson())),
//       };
// }
//
// class Unit {
//   String? year;
//   bool? iscompleted;
//   String? id;
//   String? unitName;
//
//   Unit({
//     this.year,
//     this.iscompleted,
//     this.id,
//     this.unitName,
//   });
//
//   factory Unit.fromJson(Map<String, dynamic> json) => Unit(
//         year: json["year"],
//         iscompleted: json["iscompleted"],
//         id: json["id"],
//         unitName: json["unit_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "year": year,
//         "iscompleted": iscompleted,
//         "id": id,
//         "unit_name": unitName,
//       };
// }

// To parse this JSON data, do
//
//     final dailySchedulesResponseModel = dailySchedulesResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../building_inspection_screen/models/building_model.dart';

DailySchedulesResponseModel dailySchedulesResponseModelFromJson(String str) =>
    DailySchedulesResponseModel.fromJson(json.decode(str));

String dailySchedulesResponseModelToJson(DailySchedulesResponseModel data) =>
    json.encode(data.toJson());

class DailySchedulesResponseModel {
  String? type;
  List<ScheduleDatum>? scheduleData;

  DailySchedulesResponseModel({
    this.type,
    this.scheduleData,
  });

  factory DailySchedulesResponseModel.fromJson(Map<String, dynamic> json) =>
      DailySchedulesResponseModel(
        type: json["type"],
        scheduleData: json["schedule_data"] == null
            ? []
            : List<ScheduleDatum>.from(
                json["schedule_data"]!.map((x) => ScheduleDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "schedule_data": scheduleData == null
            ? []
            : List<dynamic>.from(scheduleData!.map((x) => x.toJson())),
      };
}

class ScheduleDatum {
  String? property;
  String? name;
  String? unit;
  String? address1;
  String? city;
  String? state;
  int? counter;
  String? building;
  DateTime? date;
  String? inspector;
  String? zip;
  String? iscompleted;
  ExternalProperty? externalProperty;
  List<ExternalBuilding>? externalBuildings;
  Inspector? scheduleDatumInspector;
  bool? inspectionBuilding;
  DateTime? scheduleInspectionDate;

  ScheduleDatum({
    this.property,
    this.name,
    this.unit,
    this.address1,
    this.city,
    this.state,
    this.counter,
    this.building,
    this.date,
    this.inspector,
    this.zip,
    this.iscompleted,
    this.externalProperty,
    this.externalBuildings,
    this.scheduleDatumInspector,
    this.inspectionBuilding,
    this.scheduleInspectionDate,
  });

  factory ScheduleDatum.fromJson(Map<String, dynamic> json) => ScheduleDatum(
        property: json["Property"],
        name: json["Name"],
        unit: json["Unit"],
        address1: json["Address1"],
        city: json["City"],
        state: json["State"],
        counter: json["Counter"],
        building: json["Building"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        inspector: json["Inspector"],
        zip: json["Zip"],
        iscompleted: json["iscompleted"],
        externalProperty: json["external_property"] == null
            ? null
            : ExternalProperty.fromJson(json["external_property"]),
        externalBuildings: json["external_buildings"] == null
            ? []
            : List<ExternalBuilding>.from(json["external_buildings"]!
                .map((x) => ExternalBuilding.fromJson(x))),
        scheduleDatumInspector: json["inspector"] == null
            ? null
            : Inspector.fromJson(json["inspector"]),
        inspectionBuilding: json["inspection_building"],
        scheduleInspectionDate: json["schedule_inspection_date"] == null
            ? null
            : DateTime.parse(json["schedule_inspection_date"]),
      );

  Map<String, dynamic> toJson() => {
        "Property": property,
        "Name": name,
        "Unit": unit,
        "Address1": address1,
        "City": city,
        "State": state,
        "Counter": counter,
        "Building": building,
        "Date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "Inspector": inspector,
        "Zip": zip,
        "iscompleted": iscompleted,
        "external_property": externalProperty?.toJson(),
        "external_buildings": externalBuildings == null
            ? []
            : List<dynamic>.from(externalBuildings!.map((x) => x.toJson())),
        "inspector": scheduleDatumInspector?.toJson(),
        "inspection_building": inspectionBuilding,
        "schedule_inspection_date":
            "${scheduleInspectionDate!.year.toString().padLeft(4, '0')}-${scheduleInspectionDate!.month.toString().padLeft(2, '0')}-${scheduleInspectionDate!.day.toString().padLeft(2, '0')}",
      };
}

class ExternalBuilding {
  int? id;
  String? address1;
  dynamic address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  dynamic number;
  Property? property;
  int? constructedYear;
  BuildingType? buildingType;
  int? totalUnits;
  List<Unit>? units;

  ExternalBuilding({
    this.id,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.name,
    this.number,
    this.property,
    this.constructedYear,
    this.buildingType,
    this.totalUnits,
    this.units,
  });

  factory ExternalBuilding.fromJson(Map<String, dynamic> json) =>
      ExternalBuilding(
        id: json["id"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        name: json["name"],
        number: json["number"],
        property: json["property"] == null
            ? null
            : Property.fromJson(json["property"]),
        constructedYear: json["constructed_year"],
        buildingType: json["building_type"] == null
            ? null
            : BuildingType.fromJson(json["building_type"]),
        totalUnits: json["total_units"],
        units: json["units"] == null
            ? []
            : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "name": name,
        "number": number,
        "property": property?.toJson(),
        "constructed_year": constructedYear,
        "building_type": buildingType?.toJson(),
        "total_units": totalUnits,
        "units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
      };
}

class Property {
  int? id;
  String? address1;

  Property({
    this.id,
    this.address1,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        address1: json["address1"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
      };
}

class Unit {
  int? id;
  String? name;
  String? address;
  int? numberOfBedrooms;
  int? numberOfBathrooms;
  bool? occupied;

  Unit({
    this.id,
    this.name,
    this.address,
    this.numberOfBedrooms,
    this.numberOfBathrooms,
    this.occupied,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        numberOfBedrooms: json["number_of_bedrooms"],
        numberOfBathrooms: json["number_of_bathrooms"],
        occupied: json["occupied"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "number_of_bedrooms": numberOfBedrooms,
        "number_of_bathrooms": numberOfBathrooms,
        "occupied": occupied,
      };
}

class ExternalProperty {
  int? id;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  String? number;
  String? ampNumber;
  String? notes;

  ExternalProperty({
    this.id,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.name,
    this.number,
    this.ampNumber,
    this.notes,
  });

  factory ExternalProperty.fromJson(Map<String, dynamic> json) =>
      ExternalProperty(
        id: json["id"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        name: json["name"],
        number: json["number"],
        ampNumber: json["amp_number"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "name": name,
        "number": number,
        "amp_number": ampNumber,
        "notes": notes,
      };
}

class Inspector {
  int? id;
  int? externalAccountId;
  dynamic externalPersonalId;
  String? name;

  Inspector({
    this.id,
    this.externalAccountId,
    this.externalPersonalId,
    this.name,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        id: json["id"],
        externalAccountId: json["external_account_id"],
        externalPersonalId: json["external_personal_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_account_id": externalAccountId,
        "external_personal_id": externalPersonalId,
        "name": name,
      };
}
