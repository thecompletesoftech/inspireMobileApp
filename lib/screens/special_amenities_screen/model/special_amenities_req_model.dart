// To parse this JSON data, do
//
//     final specialAmenitiesReqModel = specialAmenitiesReqModelFromJson(jsonString);

import 'dart:convert';

SpecialAmenitiesReqModel specialAmenitiesReqModelFromJson(String str) =>
    SpecialAmenitiesReqModel.fromJson(json.decode(str));

String specialAmenitiesReqModelToJson(SpecialAmenitiesReqModel data) =>
    json.encode(data.toJson());

class SpecialAmenitiesReqModel {
  SpecialAmenities? specialAmenities;

  SpecialAmenitiesReqModel({this.specialAmenities});

  factory SpecialAmenitiesReqModel.fromJson(Map<String, dynamic> json) =>
      SpecialAmenitiesReqModel(
        specialAmenities: json["special_amenities"] == null
            ? null
            : SpecialAmenities.fromJson(json["special_amenities"]),
      );

  Map<String, dynamic> toJson() =>
      {"special_amenities": specialAmenities?.toJson()};
}

class SpecialAmenities {
  Amenities? livingRoom;
  Amenities? kitchen;
  Amenities? otherRoomsUsedForLiving;
  Amenities? bath;
  Amenities? overallCharacteristics;
  Amenities? disabledAccessibility;

  SpecialAmenities({
    this.livingRoom,
    this.kitchen,
    this.otherRoomsUsedForLiving,
    this.bath,
    this.overallCharacteristics,
    this.disabledAccessibility,
  });

  factory SpecialAmenities.fromJson(Map<String, dynamic> json) =>
      SpecialAmenities(
        livingRoom: json["living_room"] == null
            ? null
            : Amenities.fromJson(json["living_room"]),
        kitchen: json["kitchen"] == null
            ? null
            : Amenities.fromJson(json["kitchen"]),
        otherRoomsUsedForLiving: json["other_rooms_used_for_living"] == null
            ? null
            : Amenities.fromJson(json["other_rooms_used_for_living"]),
        bath: json["bath"] == null ? null : Amenities.fromJson(json["bath"]),
        overallCharacteristics: json["overall_characteristics"] == null
            ? null
            : Amenities.fromJson(json["overall_characteristics"]),
        disabledAccessibility: json["disabled_accessibility"] == null
            ? null
            : Amenities.fromJson(json["disabled_accessibility"]),
      );

  Map<String, dynamic> toJson() => {
        "living_room": livingRoom?.toJson(),
        "kitchen": kitchen?.toJson(),
        "other_rooms_used_for_living": otherRoomsUsedForLiving?.toJson(),
        "bath": bath?.toJson(),
        "overall_characteristics": overallCharacteristics?.toJson(),
        "disabled_accessibility": disabledAccessibility?.toJson(),
      };
}

class Amenities {
  String? name;
  List<String>? amenities;

  Amenities({this.name, this.amenities});

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        name: json["name"],
        amenities: json["amenities"] == null
            ? []
            : List<String>.from(json["amenities"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x)),
      };
}
