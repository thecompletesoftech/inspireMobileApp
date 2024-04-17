// To parse this JSON data, do
//
//     final deficiencyInspectionsReqModel = deficiencyInspectionsReqModelFromJson(jsonString);

import 'dart:convert';

import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

DeficiencyInspectionsReqModel deficiencyInspectionsReqModelFromJson(
        String str) =>
    DeficiencyInspectionsReqModel.fromJson(json.decode(str));

String deficiencyInspectionsReqModelToJson(
        DeficiencyInspectionsReqModel data) =>
    json.encode(data.toJson());

class DeficiencyInspectionsReqModel {
  String? housingDeficiencyId;
  String? definition;
  List<String>? deficiencyProofPictures;
  String? comment;
  bool? isSuccess;
  String? date;
  DeficiencyItemHousingDeficiency? deficiencyItemHousingDeficiency;
  String? criteria;

  DeficiencyInspectionsReqModel({
    this.housingDeficiencyId,
    this.criteria,
    this.deficiencyProofPictures,
    this.definition,
    this.comment,
    this.date,
    this.isSuccess,
    this.deficiencyItemHousingDeficiency,
  });

  factory DeficiencyInspectionsReqModel.fromJson(Map<String, dynamic> json) =>
      DeficiencyInspectionsReqModel(
        housingDeficiencyId: json["housing_deficiency_id"],
        criteria: json["criteria"],
        definition: json["definition"],
        deficiencyProofPictures: json["deficiency_proof_pictures"] == null
            ? []
            : List<String>.from(
                json["deficiency_proof_pictures"]!.map((x) => x)),
        comment: json["comment"],
        date: json["date"],
        deficiencyItemHousingDeficiency:
            json["deficiency_item_housing_deficiency"] == null
                ? null
                : DeficiencyItemHousingDeficiency.fromJson(
                    json["deficiency_item_housing_deficiency"]),
      );

  Map<String, dynamic> toJson() => {
        "housing_deficiency_id": housingDeficiencyId,
        "criteria": criteria,
        "definition": definition,
        "deficiency_proof_pictures": deficiencyProofPictures == null
            ? []
            : List<dynamic>.from(deficiencyProofPictures!.map((x) => x)),
        "comment": comment,
        "date": date,
        "deficiency_item_housing_deficiency":
            deficiencyItemHousingDeficiency?.toJson(),
      };
}
