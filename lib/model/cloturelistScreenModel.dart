class CloturelistScreenModel {
  bool? status;
  String? message;
  List<ClotureData>? data;

  CloturelistScreenModel({this.status, this.message, this.data});

  CloturelistScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ClotureData>[];
      json['data'].forEach((v) {
        data!.add(new ClotureData.fromJson(v));
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

class ClotureData {
  int? id;
  int? salesmanId;
  int? clientId;
  int? nombreDePiedLineaire;
  String? typeDeCloture;
  String? couleur;
  String? hauteur;
  int? porteSimple;
  int? porteDouble;
  int? nombreDePoteauFrostRond;
  int? nombreDePoteauPlaqueRond;
  int? nombreDeCoteauCarree;
  int? nombreDePoteauPlaqueCarree;
  String? createdAt;
  String? updatedAt;

  ClotureData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.nombreDePiedLineaire,
        this.typeDeCloture,
        this.couleur,
        this.hauteur,
        this.porteSimple,
        this.porteDouble,
        this.nombreDePoteauFrostRond,
        this.nombreDePoteauPlaqueRond,
        this.nombreDeCoteauCarree,
        this.nombreDePoteauPlaqueCarree,
        this.createdAt,
        this.updatedAt});

  ClotureData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    nombreDePiedLineaire = json['nombre_de_pied_lineaire'];
    typeDeCloture = json['type_de_cloture'];
    couleur = json['couleur'];
    hauteur = json['hauteur'];
    porteSimple = json['porte_simple'];
    porteDouble = json['porte_double'];
    nombreDePoteauFrostRond = json['nombre_de_poteau_frost_rond'];
    nombreDePoteauPlaqueRond = json['nombre_de_poteau_plaque_rond'];
    nombreDeCoteauCarree = json['nombre_de_coteau_carree'];
    nombreDePoteauPlaqueCarree = json['nombre_de_poteau_plaque_carree'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['nombre_de_pied_lineaire'] = this.nombreDePiedLineaire;
    data['type_de_cloture'] = this.typeDeCloture;
    data['couleur'] = this.couleur;
    data['hauteur'] = this.hauteur;
    data['porte_simple'] = this.porteSimple;
    data['porte_double'] = this.porteDouble;
    data['nombre_de_poteau_frost_rond'] = this.nombreDePoteauFrostRond;
    data['nombre_de_poteau_plaque_rond'] = this.nombreDePoteauPlaqueRond;
    data['nombre_de_coteau_carree'] = this.nombreDeCoteauCarree;
    data['nombre_de_poteau_plaque_carree'] = this.nombreDePoteauPlaqueCarree;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
