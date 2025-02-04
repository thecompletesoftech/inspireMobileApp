// To parse this JSON data, do
//
//     final specialAmenitiesResModel = specialAmenitiesResModelFromJson(jsonString);

import 'dart:convert';

List<SpecialAmenitiesResModel> specialAmenitiesResModelFromJson(String str) =>
    List<SpecialAmenitiesResModel>.from(
        json.decode(str).map((x) => SpecialAmenitiesResModel.fromJson(x)));

String specialAmenitiesResModelToJson(List<SpecialAmenitiesResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecialAmenitiesResModel {
  String? type;
  List<AmenitiesList>? amenitiesList;

  SpecialAmenitiesResModel({this.type, this.amenitiesList});

  factory SpecialAmenitiesResModel.fromJson(Map<String, dynamic> json) =>
      SpecialAmenitiesResModel(
        type: json["type"],
        amenitiesList: json["amenitiesList"] == null
            ? []
            : List<AmenitiesList>.from(
                json["amenitiesList"]!.map((x) => AmenitiesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amenitiesList": amenitiesList == null
            ? []
            : List<dynamic>.from(amenitiesList!.map((x) => x.toJson())),
      };
}

class AmenitiesList {
  bool? isSelected;
  String? title;
  String? titleType;

  AmenitiesList({this.isSelected, this.title, this.titleType});

  factory AmenitiesList.fromJson(Map<String, dynamic> json) => AmenitiesList(
        isSelected: json["isSelected"],
        title: json["title"],
        titleType: json["titleType"],
      );

  Map<String, dynamic> toJson() =>
      {"isSelected": isSelected, "title": title, "titleType": titleType};
}
