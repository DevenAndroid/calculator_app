class DrainListModel {
  bool? status;
  String? message;
  List<DrainData>? data;

  DrainListModel({this.status, this.message, this.data});

  DrainListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DrainData>[];
      json['data'].forEach((v) {
        data!.add(new DrainData.fromJson(v));
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

class DrainData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic typeDeDrain;
  dynamic longeur;
  List<String>? photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  List<String>? photoVideoUrl;

  DrainData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.typeDeDrain,
        this.longeur,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  DrainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    typeDeDrain = json['type_de_drain'];
    longeur = json['longeur'];
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
    data['type_de_drain'] = this.typeDeDrain;
    data['longeur'] = this.longeur;
    data['photo_video[]'] = this.photoVideo;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;

    return data;
  }
}
