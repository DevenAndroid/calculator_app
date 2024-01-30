class ExistingClientModel {
  bool? status;
  String? message;
  List<ClientData>? data;

  ExistingClientModel({this.status, this.message, this.data});

  ExistingClientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ClientData>[];
      json['data'].forEach((v) {
        data!.add(new ClientData.fromJson(v));
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

class ClientData {
  dynamic id;
  dynamic salesmanId;
  dynamic firstName;
  dynamic lastName;
  dynamic address;
  dynamic city;
  dynamic phone;
  dynamic email;
  dynamic postalCode;
  dynamic isFinalSubmit;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  List<TourbeData>? tourbeData;
  List<PaveUniData>? paveUniData;
  List<AsphalteData>? asphalteData;
  List<PlatesBandesData>? platesBandesData;
  List<MuretData>? muretData;
  List<DrainData>? drainData;
  List<MargelleData>? margelleData;

  ClientData(
      {this.id,
        this.salesmanId,
        this.firstName,
        this.lastName,
        this.address,
        this.city,
        this.phone,
        this.email,
        this.postalCode,
        this.isFinalSubmit,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.tourbeData,
        this.paveUniData,
        this.asphalteData,
        this.platesBandesData,
        this.muretData,
        this.drainData,
        this.margelleData});

  ClientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    email = json['email'];
    postalCode = json['postal_code'];
    isFinalSubmit = json['is_final_submit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['tourbe_data'] != null) {
      tourbeData = <TourbeData>[];
      json['tourbe_data'].forEach((v) {
        tourbeData!.add(new TourbeData.fromJson(v));
      });
    }
    if (json['pave_uni_data'] != null) {
      paveUniData = <PaveUniData>[];
      json['pave_uni_data'].forEach((v) {
        paveUniData!.add(new PaveUniData.fromJson(v));
      });
    }
    if (json['asphalte_data'] != null) {
      asphalteData = <AsphalteData>[];
      json['asphalte_data'].forEach((v) {
        asphalteData!.add(new AsphalteData.fromJson(v));
      });
    }
    if (json['plates_bandes_data'] != null) {
      platesBandesData = <PlatesBandesData>[];
      json['plates_bandes_data'].forEach((v) {
        platesBandesData!.add(new PlatesBandesData.fromJson(v));
      });
    }
    if (json['muret_data'] != null) {
      muretData = <MuretData>[];
      json['muret_data'].forEach((v) {
        muretData!.add(new MuretData.fromJson(v));
      });
    }
    if (json['drain_data'] != null) {
      drainData = <DrainData>[];
      json['drain_data'].forEach((v) {
        drainData!.add(new DrainData.fromJson(v));
      });
    }
    if (json['margelle_data'] != null) {
      margelleData = <MargelleData>[];
      json['margelle_data'].forEach((v) {
        margelleData!.add(new MargelleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['postal_code'] = this.postalCode;
    data['is_final_submit'] = this.isFinalSubmit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.tourbeData != null) {
      data['tourbe_data'] = this.tourbeData!.map((v) => v.toJson()).toList();
    }
    if (this.paveUniData != null) {
      data['pave_uni_data'] = this.paveUniData!.map((v) => v.toJson()).toList();
    }
    if (this.asphalteData != null) {
      data['asphalte_data'] =
          this.asphalteData!.map((v) => v.toJson()).toList();
    }
    if (this.platesBandesData != null) {
      data['plates_bandes_data'] =
          this.platesBandesData!.map((v) => v.toJson()).toList();
    }
    if (this.muretData != null) {
      data['muret_data'] = this.muretData!.map((v) => v.toJson()).toList();
    }
    if (this.drainData != null) {
      data['drain_data'] = this.drainData!.map((v) => v.toJson()).toList();
    }
    if (this.margelleData != null) {
      data['margelle_data'] =
          this.margelleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TourbeData {
  dynamic  id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic  superficie;
  dynamic profondeur;
  dynamic positionnement;
  dynamic detourber;
  dynamic typeDeDechet;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

  TourbeData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.profondeur,
        this.positionnement,
        this.detourber,
        this.typeDeDechet,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  TourbeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    profondeur = json['profondeur'];
    positionnement = json['positionnement'];
    detourber = json['detourber'];
    typeDeDechet = json['type_de_dechet'];
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['profondeur'] = this.profondeur;
    data['positionnement'] = this.positionnement;
    data['detourber'] = this.detourber;
    data['type_de_dechet'] = this.typeDeDechet;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class PaveUniData {
  dynamic  id;
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
  dynamic photoVideoUrl;

  PaveUniData(
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
        this.updatedAt,
        this.photoVideoUrl});

  PaveUniData.fromJson(Map<String, dynamic> json) {
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
    photoVideoUrl = json['photo_video_url'];
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
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class AsphalteData {
  dynamic id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic nouvelleInfra;
  dynamic positionnement;
  dynamic typeOfWaste;
  dynamic poucesAsphalte;
  dynamic contourEnPave;
  dynamic typeOfPlainPavers;
  dynamic paverColor;
  dynamic polymerSandColor;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

  AsphalteData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.nouvelleInfra,
        this.positionnement,
        this.typeOfWaste,
        this.poucesAsphalte,
        this.contourEnPave,
        this.typeOfPlainPavers,
        this.paverColor,
        this.polymerSandColor,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  AsphalteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    nouvelleInfra = json['nouvelle_infra'];
    positionnement = json['positionnement'];
    typeOfWaste = json['type_of_waste'];
    poucesAsphalte = json['pouces_asphalte'];
    contourEnPave = json['contour_en_pave'];
    typeOfPlainPavers = json['type_of_plain_pavers'];
    paverColor = json['paver_color'];
    polymerSandColor = json['polymer_sand_color'];
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['nouvelle_infra'] = this.nouvelleInfra;
    data['positionnement'] = this.positionnement;
    data['type_of_waste'] = this.typeOfWaste;
    data['pouces_asphalte'] = this.poucesAsphalte;
    data['contour_en_pave'] = this.contourEnPave;
    data['type_of_plain_pavers'] = this.typeOfPlainPavers;
    data['paver_color'] = this.paverColor;
    data['polymer_sand_color'] = this.polymerSandColor;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class PlatesBandesData {
  dynamic id;
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic profondeur;
  dynamic perimeter;
  dynamic positionnement;
  dynamic finition;
  dynamic couleurFinition;
  dynamic combienDePouces;
  dynamic bordure;
  dynamic couleur;
  dynamic plantation;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

  PlatesBandesData(
      {this.id,
        this.salesmanId,
        this.clientId,
        this.superficie,
        this.profondeur,
        this.perimeter,
        this.positionnement,
        this.finition,
        this.couleurFinition,
        this.combienDePouces,
        this.bordure,
        this.couleur,
        this.plantation,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  PlatesBandesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    clientId = json['client_id'];
    superficie = json['superficie'];
    profondeur = json['profondeur'];
    perimeter = json['perimeter'];
    positionnement = json['positionnement'];
    finition = json['finition'];
    couleurFinition = json['couleur_finition'];
    combienDePouces = json['combien_de_pouces'];
    bordure = json['bordure'];
    couleur = json['couleur'];
    plantation = json['plantation'];
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['client_id'] = this.clientId;
    data['superficie'] = this.superficie;
    data['profondeur'] = this.profondeur;
    data['perimeter'] = this.perimeter;
    data['positionnement'] = this.positionnement;
    data['finition'] = this.finition;
    data['couleur_finition'] = this.couleurFinition;
    data['combien_de_pouces'] = this.combienDePouces;
    data['bordure'] = this.bordure;
    data['couleur'] = this.couleur;
    data['plantation'] = this.plantation;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class MuretData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic superficie;
  dynamic hauteur;
  dynamic linearFeet;
  dynamic positionnement;
  dynamic typeOfWaste;
  dynamic typeDeMuret;
  dynamic paverColor;
  dynamic couronnement;
  dynamic couleurDuCouronnement;
  dynamic infrastructure;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

  MuretData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.superficie,
        this.hauteur,
        this.linearFeet,
        this.positionnement,
        this.typeOfWaste,
        this.typeDeMuret,
        this.paverColor,
        this.couronnement,
        this.couleurDuCouronnement,
        this.infrastructure,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  MuretData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    superficie = json['superficie'];
    hauteur = json['hauteur'];
    linearFeet = json['linear_feet'];
    positionnement = json['positionnement'];
    typeOfWaste = json['type_of_waste'];
    typeDeMuret = json['type_de_muret'];
    paverColor = json['paver_color'];
    couronnement = json['couronnement'];
    couleurDuCouronnement = json['couleur_du_couronnement'];
    infrastructure = json['infrastructure'];
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['superficie'] = this.superficie;
    data['hauteur'] = this.hauteur;
    data['linear_feet'] = this.linearFeet;
    data['positionnement'] = this.positionnement;
    data['type_of_waste'] = this.typeOfWaste;
    data['type_de_muret'] = this.typeDeMuret;
    data['paver_color'] = this.paverColor;
    data['couronnement'] = this.couronnement;
    data['couleur_du_couronnement'] = this.couleurDuCouronnement;
    data['infrastructure'] = this.infrastructure;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class DrainData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic typeDeDrain;
  dynamic longeur;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

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
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['type_de_drain'] = this.typeDeDrain;
    data['longeur'] = this.longeur;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}

class MargelleData {
  dynamic id;
  dynamic clientId;
  dynamic salesmanId;
  dynamic copingQuantity;
  dynamic mesure;
  dynamic note;
  dynamic photoVideo;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photoVideoUrl;

  MargelleData(
      {this.id,
        this.clientId,
        this.salesmanId,
        this.copingQuantity,
        this.mesure,
        this.note,
        this.photoVideo,
        this.createdAt,
        this.updatedAt,
        this.photoVideoUrl});

  MargelleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    salesmanId = json['salesman_id'];
    copingQuantity = json['coping_quantity'];
    mesure = json['mesure'];
    note = json['note'];
    photoVideo = json['photo_video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoVideoUrl = json['photo_video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['salesman_id'] = this.salesmanId;
    data['coping_quantity'] = this.copingQuantity;
    data['mesure'] = this.mesure;
    data['note'] = this.note;
    data['photo_video'] = this.photoVideo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo_video_url'] = this.photoVideoUrl;
    return data;
  }
}
