class PiscineListModel {
  bool? status;
  String? message;
  List<PiscineData>? data;

  PiscineListModel({this.status, this.message, this.data});

  PiscineListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PiscineData>[];
      json['data'].forEach((v) {
        data!.add(new PiscineData.fromJson(v));
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

class PiscineData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic modele;
  dynamic accessibiliteALaCour;
  dynamic couleur;
  dynamic optionSel;
  dynamic thermopompe;
  dynamic ledLumiereSupplementaire;
  dynamic controlleurBtLumiere;
  dynamic panneauAccrocheService;
  dynamic lameDeau;
  dynamic createdAt;
  dynamic updatedAt;

  PiscineData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.modele,
        this.accessibiliteALaCour,
        this.couleur,
        this.optionSel,
        this.thermopompe,
        this.ledLumiereSupplementaire,
        this.controlleurBtLumiere,
        this.panneauAccrocheService,
        this.lameDeau,
        this.createdAt,
        this.updatedAt});

  PiscineData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    modele = json['modele'];
    accessibiliteALaCour = json['accessibilite_a_la_cour'];
    couleur = json['couleur'];
    optionSel = json['option_sel'];
    thermopompe = json['thermopompe'];
    ledLumiereSupplementaire = json['led_lumiere_supplementaire'];
    controlleurBtLumiere = json['controlleur_bt_lumiere'];
    panneauAccrocheService = json['panneau_accroche_service'];
    lameDeau = json['lame_deau'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['modele'] = this.modele;
    data['accessibilite_a_la_cour'] = this.accessibiliteALaCour;
    data['couleur'] = this.couleur;
    data['option_sel'] = this.optionSel;
    data['thermopompe'] = this.thermopompe;
    data['led_lumiere_supplementaire'] = this.ledLumiereSupplementaire;
    data['controlleur_bt_lumiere'] = this.controlleurBtLumiere;
    data['panneau_accroche_service'] = this.panneauAccrocheService;
    data['lame_deau'] = this.lameDeau;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
