class Client_Info_Model {
  bool? status;
  String? message;

  Client_Info_Model({this.status, this.message});

  Client_Info_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}