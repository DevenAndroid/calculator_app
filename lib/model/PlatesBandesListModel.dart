class plates_bandes_model {
  bool? status;
  String? message;
  List<PlatesBandesData>? data;

  plates_bandes_model({this.status, this.message, this.data});

  plates_bandes_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlatesBandesData>[];
      json['data'].forEach((v) {
        data!.add(new PlatesBandesData.fromJson(v));
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

class PlatesBandesData {
  dynamic  id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic profondeur;
  dynamic perimeter;
  dynamic positionnement;
  dynamic finition;
  dynamic couleurFinition;
  dynamic combienDePouces;
  dynamic bordure;
  dynamic couleur;
  dynamic plantation;
  List<String>? photoVideo;
  dynamic quantiteDePlantation;
  dynamic note;
  dynamic createdAt;
  dynamic updatedAt;
  List<String>? photoVideoUrl;

  PlatesBandesData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.profondeur,
        this.perimeter,
        this.positionnement,
        this.finition,
        this.couleurFinition,
        this.combienDePouces,
        this.bordure,
        this.couleur,
        this.plantation,
        this.photoVideo,
        this.quantiteDePlantation,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  PlatesBandesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    profondeur = json['profondeur'];
    perimeter = json['perimeter'];
    positionnement = json['positionnement'];
    finition = json['finition'];
    couleurFinition = json['couleur_finition'];
    combienDePouces = json['combien_de_pouces'];
    bordure = json['bordure'];
    couleur = json['couleur'];
    plantation = json['plantation'];
    photoVideo = json['photo_video[]'] != null ? List<String>.from(json['photo_video[]']) : null;

    quantiteDePlantation = json['quantite_de_plantation'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'] != null ? List<String>.from(json['photo_video_url']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['profondeur'] = this.profondeur;
    data['perimeter'] = this.perimeter;
    data['positionnement'] = this.positionnement;
    data['finition'] = this.finition;
    data['couleur_finition'] = this.couleurFinition;
    data['combien_de_pouces'] = this.combienDePouces;
    data['bordure'] = this.bordure;
    data['couleur'] = this.couleur;
    data['plantation'] = this.plantation;
    data['photo_video[]'] = this.photoVideo;

    data['quantite_de_plantation[]'] = this.quantiteDePlantation;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;

    return data;
  }
}
