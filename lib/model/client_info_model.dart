class Client_Info_Model {
  bool? status;
  String? message;
  dynamic data;

  Client_Info_Model({this.status, this.message, this.data});

  Client_Info_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}