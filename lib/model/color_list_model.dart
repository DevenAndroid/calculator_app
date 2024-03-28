class ColorListModel {
  bool? status;
  String? message;
  List<Data>? data;

  ColorListModel({this.status, this.message, this.data});

  ColorListModel.fromJson(Map<String, dynamic> json) {
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
  String? colorName;
  int? id;

  Data({this.colorName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_name'] = this.colorName;
    data['id'] = this.id;
    return data;
  }
}
