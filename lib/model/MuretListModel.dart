class MuretListModel {
  bool? status;
  String? message;
  List<MuretData>? data;

  MuretListModel({this.status, this.message, this.data});

  MuretListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MuretData>[];
      json['data'].forEach((v) {
        data!.add(new MuretData.fromJson(v));
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

class MuretData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic superficie;
  dynamic hauteur;
  dynamic linearFeet;
  dynamic positionnement;
  dynamic typeOfWaste;
  dynamic typeDeMuret;
  dynamic paverColor;
  dynamic couronnement;
  dynamic couleurDuCouronnement;
  dynamic infrastructure;
  List<String>? photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  List<String>? photoVideoUrl;

  MuretData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.superficie,
        this.hauteur,
        this.linearFeet,
        this.positionnement,
        this.typeOfWaste,
        this.typeDeMuret,
        this.paverColor,
        this.couronnement,
        this.couleurDuCouronnement,
        this.infrastructure,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  MuretData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    superficie = json['superficie'];
    hauteur = json['hauteur'];
    linearFeet = json['linear_feet'];
    positionnement = json['positionnement'];
    typeOfWaste = json['type_of_waste'];
    typeDeMuret = json['type_de_muret'];
    paverColor = json['paver_color'];
    couronnement = json['couronnement'];
    couleurDuCouronnement = json['couleur_du_couronnement'];
    infrastructure = json['infrastructure'];
    photoVideo = json['photo_video[]'] != null ? List<String>.from(json['photo_video[]']) : null;

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'] != null ? List<String>.from(json['photo_video_url']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['superficie'] = this.superficie;
    data['hauteur'] = this.hauteur;
    data['linear_feet'] = this.linearFeet;
    data['positionnement'] = this.positionnement;
    data['type_of_waste'] = this.typeOfWaste;
    data['type_de_muret'] = this.typeDeMuret;
    data['paver_color'] = this.paverColor;
    data['couronnement'] = this.couronnement;
    data['couleur_du_couronnement'] = this.couleurDuCouronnement;
    data['infrastructure'] = this.infrastructure;
    data['photo_video[]'] = this.photoVideo;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;

    return data;
  }
}
