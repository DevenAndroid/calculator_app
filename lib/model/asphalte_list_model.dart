class Asphalte_list_model {
  bool? status;
  String? message;
  List<AsphalteData>? data;

  Asphalte_list_model({this.status, this.message, this.data});

  Asphalte_list_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AsphalteData>[];
      json['data'].forEach((v) {
        data!.add(new AsphalteData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AsphalteData {
  dynamic id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic nouvelleInfra;
  dynamic positionnement;
  dynamic typeOfWaste;
  dynamic poucesAsphalte;
  dynamic contourEnPave;
  dynamic typeOfPlainPavers;
  dynamic paverColor;
  dynamic polymerSandColor;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;

  AsphalteData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.nouvelleInfra,
        this.positionnement,
        this.typeOfWaste,
        this.poucesAsphalte,
        this.contourEnPave,
        this.typeOfPlainPavers,
        this.paverColor,
        this.polymerSandColor,
        this.photoVideo,
        this.createdAt,
        this.updatedAt});

  AsphalteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    nouvelleInfra = json['nouvelle_infra'];
    positionnement = json['positionnement'];
    typeOfWaste = json['type_of_waste'];
    poucesAsphalte = json['pouces_asphalte'];
    contourEnPave = json['contour_en_pave'];
    typeOfPlainPavers = json['type_of_plain_pavers'];
    paverColor = json['paver_color'];
    polymerSandColor = json['polymer_sand_color'];
    photoVideo = json['photo_video_url'
        ''];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['nouvelle_infra'] = this.nouvelleInfra;
    data['positionnement'] = this.positionnement;
    data['type_of_waste'] = this.typeOfWaste;
    data['pouces_asphalte'] = this.poucesAsphalte;
    data['contour_en_pave'] = this.contourEnPave;
    data['type_of_plain_pavers'] = this.typeOfPlainPavers;
    data['paver_color'] = this.paverColor;
    data['polymer_sand_color'] = this.polymerSandColor;
    data['photo_video_url'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
