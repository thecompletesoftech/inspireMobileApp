// To parse this JSON data, do
//
//     final dailySchedulesResponseModel = dailySchedulesResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final dailySchedulesResponseModel = dailySchedulesResponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_res_model.dart';
import 'package:public_housing/screens/inspection_list_screen/model/inspection_req_model.dart';

DailySchedulesResponseModel dailySchedulesResponseModelFromJson(String str) =>
    DailySchedulesResponseModel.fromJson(json.decode(str));

String dailySchedulesResponseModelToJson(DailySchedulesResponseModel data) =>
    json.encode(data.toJson());

class DailySchedulesResponseModel {
  String? type;
  List<ScheduleInspection>? scheduleInspections;

  DailySchedulesResponseModel({this.type, this.scheduleInspections});

  factory DailySchedulesResponseModel.fromJson(Map<String, dynamic> json) =>
      DailySchedulesResponseModel(
        type: json["type"],
        scheduleInspections: json["schedule_inspections"] == null
            ? []
            : List<ScheduleInspection>.from(json["schedule_inspections"]!
                .map((x) => ScheduleInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "schedule_inspections": scheduleInspections == null
            ? []
            : List<dynamic>.from(scheduleInspections!.map((x) => x.toJson())),
      };
}

class ScheduleInspection {
  int? id;
  DateTime? scheduleDate;
  Status? status;
  Inspector? inspector;
  ScheduleInspectionProperty? property;
  List<ScheduleInspectionBuilding>? scheduleInspectionBuildings;
  String? formattedScheduleDate;

  ScheduleInspection({
    this.id,
    this.scheduleDate,
    this.status,
    this.inspector,
    this.property,
    this.scheduleInspectionBuildings,
    this.formattedScheduleDate,
  });

  factory ScheduleInspection.fromJson(Map<String, dynamic> json) =>
      ScheduleInspection(
        id: json["id"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        inspector: json["inspector"] == null
            ? null
            : Inspector.fromJson(json["inspector"]),
        property: json["property"] == null
            ? null
            : ScheduleInspectionProperty.fromJson(json["property"]),
        scheduleInspectionBuildings:
            json["schedule_inspection_buildings"] == null
                ? []
                : List<ScheduleInspectionBuilding>.from(
                    json["schedule_inspection_buildings"]!
                        .map((x) => ScheduleInspectionBuilding.fromJson(x))),
        formattedScheduleDate: json["formatted_schedule_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date": scheduleDate?.toIso8601String(),
        "status": status?.toJson(),
        "inspector": inspector?.toJson(),
        "property": property?.toJson(),
        "schedule_inspection_buildings": scheduleInspectionBuildings == null
            ? []
            : List<dynamic>.from(
                scheduleInspectionBuildings!.map((x) => x.toJson())),
        "formatted_schedule_date": formattedScheduleDate,
      };
}

class Status {
  int? id;
  String? value;

  Status({this.id, this.value});

  factory Status.fromJson(Map<String, dynamic> json) =>
      Status(id: json["id"], value: json["value"]);

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}

class Inspector {
  int? id;
  int? externalAccountId;
  dynamic externalPersonalId;
  String? name;

  Inspector(
      {this.id, this.externalAccountId, this.externalPersonalId, this.name});

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

class ScheduleInspectionProperty {
  int? id;
  String? address1;
  dynamic address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  String? number;
  dynamic ampNumber;
  String? notes;

  ScheduleInspectionProperty({
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

  factory ScheduleInspectionProperty.fromJson(Map<String, dynamic> json) =>
      ScheduleInspectionProperty(
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

class ScheduleInspectionBuilding {
  int? id;
  bool? isBuildingInspection;
  Building? building;
  List<ScheduleInspectionUnit>? scheduleInspectionUnits;
  DateTime? dateTime;
  ScheduleInspection? propertyData;
  InspectionStatus? inspectionStatus;

  ScheduleInspectionBuilding(
      {this.id,
      this.isBuildingInspection,
      this.building,
      this.scheduleInspectionUnits,
      this.dateTime,
      this.propertyData,
      this.inspectionStatus});

  factory ScheduleInspectionBuilding.fromJson(Map<String, dynamic> json) =>
      ScheduleInspectionBuilding(
        id: json["id"],
        isBuildingInspection: json["is_building_inspection"],
        building: json["building"] == null
            ? null
            : Building.fromJson(json["building"]),
        inspectionStatus: json["inspection_status"] == null
            ? null
            : InspectionStatus.fromJson(json["inspection_status"]),
        scheduleInspectionUnits: json["schedule_inspection_units"] == null
            ? []
            : List<ScheduleInspectionUnit>.from(
                json["schedule_inspection_units"]!
                    .map((x) => ScheduleInspectionUnit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_building_inspection": isBuildingInspection,
        "building": building?.toJson(),
        "inspection_status": inspectionStatus?.toJson(),
        "schedule_inspection_units": scheduleInspectionUnits == null
            ? []
            : List<dynamic>.from(
                scheduleInspectionUnits!.map((x) => x.toJson())),
      };
}

class Building {
  int? id;
  String? address1;
  dynamic address2;
  String? city;
  String? state;
  String? zip;
  String? name;
  dynamic number;
  BuildingProperty? property;
  int? constructedYear;
  BuildingType? buildingType;

  Building({
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
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
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
            : BuildingProperty.fromJson(json["property"]),
        constructedYear: json["constructed_year"],
        buildingType: json["building_type"] == null
            ? null
            : BuildingType.fromJson(json["building_type"]),
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
      };
}

class BuildingType {
  int? id;
  String? name;
  dynamic description;

  BuildingType({this.id, this.name, this.description});

  factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
      id: json["id"], name: json["name"], description: json["description"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "description": description};
}

class BuildingProperty {
  int? id;
  String? address1;

  BuildingProperty({this.id, this.address1});

  factory BuildingProperty.fromJson(Map<String, dynamic> json) =>
      BuildingProperty(id: json["id"], address1: json["address1"]);

  Map<String, dynamic> toJson() => {"id": id, "address1": address1};
}

class ScheduleInspectionUnit {
  int? id;
  Unit? unit;
  InspectionStatus? inspectionStatus;
  DateTime? dateTime;
  ScheduleInspection? propertyData;

  ScheduleInspectionUnit({
    this.id,
    this.unit,
    this.inspectionStatus,
    this.dateTime,
    this.propertyData,
  });

  factory ScheduleInspectionUnit.fromJson(Map<String, dynamic> json) =>
      ScheduleInspectionUnit(
        id: json["id"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        inspectionStatus: json["inspection_status"] == null
            ? null
            : InspectionStatus.fromJson(json["inspection_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit?.toJson(),
        "inspection_status": inspectionStatus?.toJson(),
      };
}

class InspectionStatus {
  int? id;
  String? value;

  InspectionStatus({this.id, this.value});

  factory InspectionStatus.fromJson(Map<String, dynamic> json) =>
      InspectionStatus(id: json["id"], value: json["value"]);

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
