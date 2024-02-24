class CertificateModel {
  String? type;
  List<Certificates>? certificates;

  CertificateModel({this.type, this.certificates});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['certificates'] != null) {
      certificates = <Certificates>[];
      json['certificates'].forEach((v) {
        certificates!.add(new Certificates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.certificates != null) {
      data['certificates'] = this.certificates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Certificates {
  int? id;
  String? certificate;

  Certificates({this.id, this.certificate});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    certificate = json['certificate'];
  }

  set isChecked(isChecked) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['certificate'] = this.certificate;
    return data;
  }
}
