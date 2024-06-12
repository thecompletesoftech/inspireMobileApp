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
  Building? building;

  ScheduleDatum({
    this.state,
    this.zip,
    this.city,
    this.date,
    this.property,
    this.building,
  });

  factory ScheduleDatum.fromJson(Map<String, dynamic> json) => ScheduleDatum(
        state: json["State"],
        zip: json["Zip"],
        city: json["City"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        property: json["Property"],
        building: json["building"] == null
            ? null
            : Building.fromJson(json["building"]),
      );

  Map<String, dynamic> toJson() => {
        "State": state,
        "Zip": zip,
        "City": city,
        "Date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "Property": property,
        "building": building?.toJson(),
      };
}

class Building {
  String? buildingName;
  String? buildingType;
  String? year;
  bool? iscompleted;
  String? id;
  List<Unit>? units;

  Building({
    this.buildingName,
    this.buildingType,
    this.year,
    this.iscompleted,
    this.id,
    this.units,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        buildingName: json["building_name"],
        buildingType: json["building_type"],
        year: json["year"],
        iscompleted: json["iscompleted"],
        id: json["id"],
        units: json["Units"] == null
            ? []
            : List<Unit>.from(json["Units"]!.map((x) => Unit.fromJson(x))),
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

class Unit {
  String? year;
  bool? iscompleted;
  String? id;
  String? unitName;

  Unit({
    this.year,
    this.iscompleted,
    this.id,
    this.unitName,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        year: json["year"],
        iscompleted: json["iscompleted"],
        id: json["id"],
        unitName: json["unit_name"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "iscompleted": iscompleted,
        "id": id,
        "unit_name": unitName,
      };
}
