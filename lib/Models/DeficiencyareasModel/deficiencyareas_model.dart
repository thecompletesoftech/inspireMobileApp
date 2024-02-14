class DeficiencyAreaModel {
  String? type;
  List<DeficiencyAreas>? deficiencyAreas;

  DeficiencyAreaModel({this.type, this.deficiencyAreas});

  DeficiencyAreaModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['deficiency_areas'] != null) {
      deficiencyAreas = <DeficiencyAreas>[];
      json['deficiency_areas'].forEach((v) {
        deficiencyAreas!.add(new DeficiencyAreas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.deficiencyAreas != null) {
      data['deficiency_areas'] =
          this.deficiencyAreas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeficiencyAreas {
  int? id;
  String? name;
  String? definition;
  String? purpose;
  String? commonComponents;
  String? moreInformation;
  List<DeficiencyAreaItems>? deficiencyAreaItems;

  DeficiencyAreas(
      {this.id,
      this.name,
      this.definition,
      this.purpose,
      this.commonComponents,
      this.moreInformation,
      this.deficiencyAreaItems});

  DeficiencyAreas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    definition = json['definition'];
    purpose = json['purpose'];
    commonComponents = json['common_components'];
    moreInformation = json['more_information'];
    if (json['deficiency_area_items'] != null) {
      deficiencyAreaItems = <DeficiencyAreaItems>[];
      json['deficiency_area_items'].forEach((v) {
        deficiencyAreaItems!.add(new DeficiencyAreaItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['definition'] = this.definition;
    data['purpose'] = this.purpose;
    data['common_components'] = this.commonComponents;
    data['more_information'] = this.moreInformation;
    if (this.deficiencyAreaItems != null) {
      data['deficiency_area_items'] =
          this.deficiencyAreaItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeficiencyAreaItems {
  int? id;
  String? description;
  String? note;
  String? criteria;
  List<DeficiencyItemHousingDeficiency>? deficiencyItemHousingDeficiency;

  DeficiencyAreaItems(
      {this.id,
      this.description,
      this.note,
      this.criteria,
      this.deficiencyItemHousingDeficiency});

  DeficiencyAreaItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    note = json['note'];
    criteria = json['criteria'];
    if (json['deficiency_item_housing_deficiency'] != null) {
      deficiencyItemHousingDeficiency = <DeficiencyItemHousingDeficiency>[];
      json['deficiency_item_housing_deficiency'].forEach((v) {
        deficiencyItemHousingDeficiency!
            .add(new DeficiencyItemHousingDeficiency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['note'] = this.note;
    data['criteria'] = this.criteria;
    if (this.deficiencyItemHousingDeficiency != null) {
      data['deficiency_item_housing_deficiency'] =
          this.deficiencyItemHousingDeficiency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeficiencyItemHousingDeficiency {
  int? id;
  Severity? severity;
  HousingItem? housingItem;

  DeficiencyItemHousingDeficiency({this.id, this.severity, this.housingItem});

  DeficiencyItemHousingDeficiency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'] != null
        ? new Severity.fromJson(json['severity'])
        : null;
    housingItem = json['housing_item'] != null
        ? new HousingItem.fromJson(json['housing_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.severity != null) {
      data['severity'] = this.severity!.toJson();
    }
    if (this.housingItem != null) {
      data['housing_item'] = this.housingItem!.toJson();
    }
    return data;
  }
}

class Severity {
  int? id;
  String? healthySafetyDesignation;
  String? correctionTimeFrame;

  Severity({this.id, this.healthySafetyDesignation, this.correctionTimeFrame});

  Severity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    healthySafetyDesignation = json['healthy_safety_designation'];
    correctionTimeFrame = json['correction_time_frame'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['healthy_safety_designation'] = this.healthySafetyDesignation;
    data['correction_time_frame'] = this.correctionTimeFrame;
    return data;
  }
}

class HousingItem {
  int? id;
  String? item;
  String? description;

  HousingItem({this.id, this.item, this.description});

  HousingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['description'] = this.description;
    return data;
  }
}

