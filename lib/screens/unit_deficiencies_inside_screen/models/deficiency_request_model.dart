// To parse this JSON data, do
//
//     final deficiencyRequestModel = deficiencyRequestModelFromJson(jsonString);

import 'dart:convert';

DeficiencyRequestModel deficiencyRequestModelFromJson(String str) =>
    DeficiencyRequestModel.fromJson(json.decode(str));

String deficiencyRequestModelToJson(DeficiencyRequestModel data) =>
    json.encode(data.toJson());

class DeficiencyRequestModel {
  String? housingDeficiencyId;
  List<DeficiencyProofPicture>? deficiencyProofPictures;
  String? comment;
  String? dateTime;

  DeficiencyRequestModel({
    this.housingDeficiencyId,
    this.deficiencyProofPictures,
    this.comment,
    this.dateTime,
  });

  factory DeficiencyRequestModel.fromJson(Map<String, dynamic> json) =>
      DeficiencyRequestModel(
        housingDeficiencyId: json["housing_deficiency_id"],
        dateTime: json["dateTime"],
        deficiencyProofPictures: json["deficiency_proof_pictures"] == null
            ? []
            : List<DeficiencyProofPicture>.from(
                json["deficiency_proof_pictures"]!
                    .map((x) => DeficiencyProofPicture.fromJson(x))),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "housing_deficiency_id": housingDeficiencyId,
        "dateTime": dateTime,
        "deficiency_proof_pictures": deficiencyProofPictures == null
            ? []
            : List<dynamic>.from(
                deficiencyProofPictures!.map((x) => x.toJson())),
        "comment": comment,
      };
}

class DeficiencyProofPicture {
  String? picturePath;

  DeficiencyProofPicture({this.picturePath});

  factory DeficiencyProofPicture.fromJson(Map<String, dynamic> json) =>
      DeficiencyProofPicture(picturePath: json["picture_path"]);

  Map<String, dynamic> toJson() => {"picture_path": picturePath};
}
