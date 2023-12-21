class PaveuniListModel {
  bool? status;
  String? message;
  List<Data>? data;

  PaveuniListModel({this.status, this.message, this.data});

  PaveuniListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic superficie;
  dynamic perimeter;
  dynamic typeDeBordure;
  dynamic positionnement;
  dynamic typeOfWaste;
  dynamic typeToPavage;
  dynamic couleurDePave;
  dynamic polymerSandColor;
  dynamic photo;
  dynamic photoVideo;
  dynamic infrastructure;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.superficie,
        this.perimeter,
        this.typeDeBordure,
        this.positionnement,
        this.typeOfWaste,
        this.typeToPavage,
        this.couleurDePave,
        this.polymerSandColor,
        this.photo,
        this.photoVideo,
        this.infrastructure,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    superficie = json['superficie'];
    perimeter = json['perimeter'];
    typeDeBordure = json['type_de_bordure'];
    positionnement = json['positionnement'];
    typeOfWaste = json['type_of_waste'];
    typeToPavage = json['type_to_pavage'];
    couleurDePave = json['couleur_de_pave'];
    polymerSandColor = json['polymer_sand_color'];
    photo = json['photo'];
    photoVideo = json['photo_video'];
    infrastructure = json['infrastructure'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['superficie'] = this.superficie;
    data['perimeter'] = this.perimeter;
    data['type_de_bordure'] = this.typeDeBordure;
    data['positionnement'] = this.positionnement;
    data['type_of_waste'] = this.typeOfWaste;
    data['type_to_pavage'] = this.typeToPavage;
    data['couleur_de_pave'] = this.couleurDePave;
    data['polymer_sand_color'] = this.polymerSandColor;
    data['photo'] = this.photo;
    data['photo_video'] = this.photoVideo;
    data['infrastructure'] = this.infrastructure;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
