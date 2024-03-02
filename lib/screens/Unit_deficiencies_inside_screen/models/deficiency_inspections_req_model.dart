// To parse this JSON data, do
//
//     final deficiencyInspectionsReqModel = deficiencyInspectionsReqModelFromJson(jsonString);

import 'dart:convert';

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

  DeficiencyInspectionsReqModel({
    this.housingDeficiencyId,
    this.deficiencyProofPictures,
    this.definition,
    this.comment,
    this.date,
    this.isSuccess,
  });

  factory DeficiencyInspectionsReqModel.fromJson(Map<String, dynamic> json) =>
      DeficiencyInspectionsReqModel(
        housingDeficiencyId: json["housing_deficiency_id"],
        definition: json["definition"],
        deficiencyProofPictures: json["deficiency_proof_pictures"] == null
            ? []
            : List<String>.from(
                json["deficiency_proof_pictures"]!.map((x) => x)),
        comment: json["comment"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "housing_deficiency_id": housingDeficiencyId,
        "definition": definition,
        "deficiency_proof_pictures": deficiencyProofPictures == null
            ? []
            : List<dynamic>.from(deficiencyProofPictures!.map((x) => x)),
        "comment": comment,
        "date": date,
      };
}
