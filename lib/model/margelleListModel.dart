class MargelleListModel {
  bool? status;
  String? message;
  List<MargelleData>? data;

  MargelleListModel({this.status, this.message, this.data});

  MargelleListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MargelleData>[];
      json['data'].forEach((v) {
        data!.add(new MargelleData.fromJson(v));
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

class MargelleData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic copingQuantity;
  dynamic mesure;
  dynamic note;
  List<String>?    photoVideo;
  dynamic deFenetre;
  dynamic mesureDeMargelle;
  dynamic createdAt;
  dynamic updatedAt;
  List<String>? photoVideoUrl;

  MargelleData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.copingQuantity,
        this.mesure,
        this.note,
        this.photoVideo,
        this.deFenetre,
        this.mesureDeMargelle,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  MargelleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    copingQuantity = json['coping_quantity'];
    mesure = json['mesure'];
    note = json['note'];
    photoVideo = json['photo_video[]'] != null ? List<String>.from(json['photo_video[]']) : null;
    deFenetre = json['de_fenetre'];
    mesureDeMargelle = json['mesure_de_margelle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'] != null ? List<String>.from(json['photo_video_url']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['coping_quantity'] = this.copingQuantity;
    data['mesure'] = this.mesure;
    data['note'] = this.note;
    data['photo_video[]'] = this.photoVideo;
    data['de_fenetre'] = this.deFenetre;
    data['mesure_de_margelle'] = this.mesureDeMargelle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;

    return data;
  }
}
