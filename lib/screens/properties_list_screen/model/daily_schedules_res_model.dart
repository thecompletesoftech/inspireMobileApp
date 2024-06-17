// To parse this JSON data, do
//
//     final dailySchedulesResponseModel = dailySchedulesResponseModelFromJson(jsonString);

import 'dart:convert';

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
  String? state;
  String? zip;
  String? city;
  DateTime? date;
  String? property;
  String? propertyName;
  List<BuildingsData>? buildings;

  ScheduleDatum({
    this.state,
    this.zip,
    this.city,
    this.date,
    this.property,
    this.propertyName,
    this.buildings,
  });

  factory ScheduleDatum.fromJson(Map<String, dynamic> json) => ScheduleDatum(
        state: json["State"],
        zip: json["Zip"],
        city: json["City"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        property: json["Property"],
        propertyName: json["Property name"],
        buildings: json["buildings"] == null
            ? []
            : List<BuildingsData>.from(
                json["buildings"]!.map((x) => BuildingsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "State": state,
        "Zip": zip,
        "City": city,
        "Date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "Property": property,
        "Property name": propertyName,
        "buildings": buildings == null
            ? []
            : List<dynamic>.from(buildings!.map((x) => x.toJson())),
      };
}

class BuildingsData {
  String? buildingName;
  String? buildingType;
  int? year;
  bool? iscompleted;
  String? id;
  List<UnitsData>? units;
  DateTime? date;

  BuildingsData({
    this.buildingName,
    this.buildingType,
    this.year,
    this.iscompleted,
    this.id,
    this.units,
    this.date,
  });

  factory BuildingsData.fromJson(Map<String, dynamic> json) => BuildingsData(
        buildingName: json["building_name"],
        buildingType: json["building_type"],
        year: json["year"],
        iscompleted: json["iscompleted"],
        id: json["id"],
        units: json["Units"] == null
            ? []
            : List<UnitsData>.from(
                json["Units"]!.map((x) => UnitsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "building_name": buildingName,
        "building_type": buildingType,
        "year": year,
        "iscompleted": iscompleted,
        "id": id,
        "Units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
      };
}

class UnitsData {
  bool? iscompleted;
  String? id;
  String? unitName;
  DateTime? date;

  UnitsData({
    this.iscompleted,
    this.id,
    this.unitName,
    this.date,
  });

  factory UnitsData.fromJson(Map<String, dynamic> json) => UnitsData(
        iscompleted: json["iscompleted"],
        id: json["id"],
        unitName: json["unit_name"],
      );

  Map<String, dynamic> toJson() => {
        "iscompleted": iscompleted,
        "id": id,
        "unit_name": unitName,
      };
}
