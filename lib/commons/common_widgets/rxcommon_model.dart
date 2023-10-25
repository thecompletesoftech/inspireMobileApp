import 'dart:io';

class RxCommonModel {
  int? id = 0;
  String? image = '';
  File? fileImg;
  String? imgId = '';
  String? title = '';
  String? subtitle = '';
  String? status = '';
  String? massage = '';
  String? failMessage = '';
  double? lat = 0.0;
  double? lng = 0.0;
  bool? check = false;

  RxCommonModel(
      {this.id,
      this.image,
      this.fileImg,
      this.imgId,
      this.title,
      this.subtitle,
      this.check,
      this.status,
      this.lat,
      this.lng,
      this.massage,
      this.failMessage});

  factory RxCommonModel.fromDocument(RxCommonModel document) {
    return RxCommonModel(
        id: document.id,
        image: document.image,
        fileImg: document.fileImg,
        imgId: document.imgId,
        title: document.title,
        subtitle: document.subtitle,
        check: document.check,
        status: document.status,
        massage: document.massage,
        lat: document.lat,
        lng: document.lng,
        failMessage: document.failMessage);
  }
}
