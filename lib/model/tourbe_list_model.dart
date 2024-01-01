
class DetailsListModel {
  bool? status;
  String? message;
  List<Data>? data;

  DetailsListModel({this.status, this.message, this.data});

  DetailsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  dynamic id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic  profondeur;
  dynamic  positionnement;
  dynamic  detourber;
  dynamic  typeDeDechet;
  dynamic  photoVideo;
  dynamic  createdAt;
  dynamic  updatedAt;

  Data(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.profondeur,
        this.positionnement,
        this.detourber,
        this.typeDeDechet,
        this.photoVideo,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    profondeur = json['profondeur'];
    positionnement = json['positionnement'];
    detourber = json['detourber'];
    typeDeDechet = json['type_de_dechet'];
    photoVideo = json['photo_video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['profondeur'] = this.profondeur;
    data['positionnement'] = this.positionnement;
    data['detourber'] = this.detourber;
    data['type_de_dechet'] = this.typeDeDechet;
    data['photo_video_url'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

