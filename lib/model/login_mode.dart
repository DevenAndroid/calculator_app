class LoginModel {
  bool? status;
  String? message;
  String? authToken;
  Data? data;

  LoginModel({this.status, this.message, this.authToken, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authToken = json['auth_token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['auth_token'] = this.authToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? status;
  String? address;
  String? country;
  String? countryName;
  String? state;
  String? stateName;
  String? city;
  String? zipCode;
  String? profileImage;
  int? roleId;
  String? role;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.status,
        this.address,
        this.country,
        this.countryName,
        this.state,
        this.stateName,
        this.city,
        this.zipCode,
        this.profileImage,
        this.roleId,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    stateName = json['state_name'];
    city = json['city'];
    zipCode = json['zip_code'];
    profileImage = json['profile_image'];
    roleId = json['role_id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['address'] = this.address;
    data['country'] = this.country;
    data['country_name'] = this.countryName;
    data['state'] = this.state;
    data['state_name'] = this.stateName;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['profile_image'] = this.profileImage;
    data['role_id'] = this.roleId;
    data['role'] = this.role;
    return data;
  }
}
