class DrainListModel {
  bool? status;
  String? message;
  List<Data>? data;

  DrainListModel({this.status, this.message, this.data});

  DrainListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic clientId;
  dynamic salesmanId;
  dynamic typeDeDrain;
  dynamic longeur;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
      this.clientId,
      this.salesmanId,
      this.typeDeDrain,
      this.longeur,
      this.photoVideo,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    typeDeDrain = json['type_de_drain'];
    longeur = json['longeur'];
    photoVideo = json['photo_video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['type_de_drain'] = this.typeDeDrain;
    data['longeur'] = this.longeur;
    data['photo_video_url'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
