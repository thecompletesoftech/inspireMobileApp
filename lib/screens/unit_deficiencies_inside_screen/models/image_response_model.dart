// To parse this JSON data, do
//
//     final imageResponseModel = imageResponseModelFromJson(jsonString);

import 'dart:convert';

ImageResponseModel imageResponseModelFromJson(String str) =>
    ImageResponseModel.fromJson(json.decode(str));

String imageResponseModelToJson(ImageResponseModel data) =>
    json.encode(data.toJson());

class ImageResponseModel {
  String? type;
  Images? images;

  ImageResponseModel({this.type, this.images});

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) =>
      ImageResponseModel(
        type: json["type"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "images": images?.toJson(),
      };
}

class Images {
  String? image;

  Images({this.image});

  factory Images.fromJson(Map<String, dynamic> json) =>
      Images(image: json["image"]);

  Map<String, dynamic> toJson() => {"image": image};
}
