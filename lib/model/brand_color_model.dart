class BrandColorModel {
  bool? status;
  String? message;
  List<Data>? data;

  BrandColorModel({this.status, this.message, this.data});

  BrandColorModel.fromJson(Map<String, dynamic> json) {
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
  String? brandName;
  String? createdAt;
  int? id;

  Data({this.brandName, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
