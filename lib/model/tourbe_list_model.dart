// class DetailsListModel {
//   String? message;
//   String? status;
//   List<TourbedataList>? tourbedataList;
//   List<PaveUniData>? paveUniData;
//   List<AsphalteData>? asphalteData;
//   List<PlatesBandesData>? platesBandesData;
//   List<MuretData>? muretData;
//   List<DrainData>? drainData;
//   List<MargelleData>? margelleData;
//
//   DetailsListModel(
//       {this.message,
//         this.status,
//         this.tourbedataList,
//         this.paveUniData,
//         this.asphalteData,
//         this.platesBandesData,
//         this.muretData,
//         this.drainData,
//         this.margelleData});
//
//   DetailsListModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     if (json['Tourbedata List'] != null) {
//       tourbedataList = <TourbedataList>[];
//       json['Tourbedata List'].forEach((v) {
//         tourbedataList!.add(new TourbedataList.fromJson(v));
//       });
//     }
//     if (json['PaveUniData'] != null) {
//       paveUniData = <PaveUniData>[];
//       json['PaveUniData'].forEach((v) {
//         paveUniData!.add(new PaveUniData.fromJson(v));
//       });
//     }
//     if (json['AsphalteData'] != null) {
//       asphalteData = <AsphalteData>[];
//       json['AsphalteData'].forEach((v) {
//         asphalteData!.add(new AsphalteData.fromJson(v));
//       });
//     }
//     if (json['PlatesBandesData'] != null) {
//       platesBandesData = <PlatesBandesData>[];
//       json['PlatesBandesData'].forEach((v) {
//         platesBandesData!.add(new PlatesBandesData.fromJson(v));
//       });
//     }
//     if (json['MuretData'] != null) {
//       muretData = <MuretData>[];
//       json['MuretData'].forEach((v) {
//         muretData!.add(new MuretData.fromJson(v));
//       });
//     }
//     if (json['DrainData'] != null) {
//       drainData = <DrainData>[];
//       json['DrainData'].forEach((v) {
//         drainData!.add(new DrainData.fromJson(v));
//       });
//     }
//     if (json['MargelleData'] != null) {
//       margelleData = <MargelleData>[];
//       json['MargelleData'].forEach((v) {
//         margelleData!.add(new MargelleData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.tourbedataList != null) {
//       data['Tourbedata List'] =
//           this.tourbedataList!.map((v) => v.toJson()).toList();
//     }
//     if (this.paveUniData != null) {
//       data['PaveUniData'] = this.paveUniData!.map((v) => v.toJson()).toList();
//     }
//     if (this.asphalteData != null) {
//       data['AsphalteData'] = this.asphalteData!.map((v) => v.toJson()).toList();
//     }
//     if (this.platesBandesData != null) {
//       data['PlatesBandesData'] =
//           this.platesBandesData!.map((v) => v.toJson()).toList();
//     }
//     if (this.muretData != null) {
//       data['MuretData'] = this.muretData!.map((v) => v.toJson()).toList();
//     }
//     if (this.drainData != null) {
//       data['DrainData'] = this.drainData!.map((v) => v.toJson()).toList();
//     }
//     if (this.margelleData != null) {
//       data['MargelleData'] = this.margelleData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class TourbedataList {
//   int? id;
//   int? salesmanId;
//   int? clientId;
//   int? superficie;
//   double? profondeur;
//   String? positionnement;
//   String? detourber;
//   String? typeDeDechet;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   TourbedataList(
//       {this.id,
//         this.salesmanId,
//         this.clientId,
//         this.superficie,
//         this.profondeur,
//         this.positionnement,
//         this.detourber,
//         this.typeDeDechet,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   TourbedataList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     salesmanId = json['salesman_id'];
//     clientId = json['client_id'];
//     superficie = json['superficie'];
//     profondeur = json['profondeur'];
//     positionnement = json['positionnement'];
//     detourber = json['detourber'];
//     typeDeDechet = json['type_de_dechet'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['salesman_id'] = this.salesmanId;
//     data['client_id'] = this.clientId;
//     data['superficie'] = this.superficie;
//     data['profondeur'] = this.profondeur;
//     data['positionnement'] = this.positionnement;
//     data['detourber'] = this.detourber;
//     data['type_de_dechet'] = this.typeDeDechet;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class PaveUniData {
//   int? id;
//   int? clientId;
//   int? salesmanId;
//   double? superficie;
//   double? perimeter;
//   String? typeDeBordure;
//   String? positionnement;
//   String? typeOfWaste;
//   String? typeToPavage;
//   String? couleurDePave;
//   String? polymerSandColor;
//   String? photo;
//   String? photoVideo;
//   String? infrastructure;
//   String? createdAt;
//   String? updatedAt;
//
//   PaveUniData(
//       {this.id,
//         this.clientId,
//         this.salesmanId,
//         this.superficie,
//         this.perimeter,
//         this.typeDeBordure,
//         this.positionnement,
//         this.typeOfWaste,
//         this.typeToPavage,
//         this.couleurDePave,
//         this.polymerSandColor,
//         this.photo,
//         this.photoVideo,
//         this.infrastructure,
//         this.createdAt,
//         this.updatedAt});
//
//   PaveUniData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     clientId = json['client_id'];
//     salesmanId = json['salesman_id'];
//     superficie = json['superficie'];
//     perimeter = json['perimeter'];
//     typeDeBordure = json['type_de_bordure'];
//     positionnement = json['positionnement'];
//     typeOfWaste = json['type_of_waste'];
//     typeToPavage = json['type_to_pavage'];
//     couleurDePave = json['couleur_de_pave'];
//     polymerSandColor = json['polymer_sand_color'];
//     photo = json['photo'];
//     photoVideo = json['photo_video'];
//     infrastructure = json['infrastructure'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['client_id'] = this.clientId;
//     data['salesman_id'] = this.salesmanId;
//     data['superficie'] = this.superficie;
//     data['perimeter'] = this.perimeter;
//     data['type_de_bordure'] = this.typeDeBordure;
//     data['positionnement'] = this.positionnement;
//     data['type_of_waste'] = this.typeOfWaste;
//     data['type_to_pavage'] = this.typeToPavage;
//     data['couleur_de_pave'] = this.couleurDePave;
//     data['polymer_sand_color'] = this.polymerSandColor;
//     data['photo'] = this.photo;
//     data['photo_video'] = this.photoVideo;
//     data['infrastructure'] = this.infrastructure;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class AsphalteData {
//   int? id;
//   int? salesmanId;
//   int? clientId;
//   double? superficie;
//   String? nouvelleInfra;
//   String? positionnement;
//   String? typeOfWaste;
//   int? poucesAsphalte;
//   String? contourEnPave;
//   String? typeOfPlainPavers;
//   String? paverColor;
//   String? polymerSandColor;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   AsphalteData(
//       {this.id,
//         this.salesmanId,
//         this.clientId,
//         this.superficie,
//         this.nouvelleInfra,
//         this.positionnement,
//         this.typeOfWaste,
//         this.poucesAsphalte,
//         this.contourEnPave,
//         this.typeOfPlainPavers,
//         this.paverColor,
//         this.polymerSandColor,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   AsphalteData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     salesmanId = json['salesman_id'];
//     clientId = json['client_id'];
//     superficie = json['superficie'];
//     nouvelleInfra = json['nouvelle_infra'];
//     positionnement = json['positionnement'];
//     typeOfWaste = json['type_of_waste'];
//     poucesAsphalte = json['pouces_asphalte'];
//     contourEnPave = json['contour_en_pave'];
//     typeOfPlainPavers = json['type_of_plain_pavers'];
//     paverColor = json['paver_color'];
//     polymerSandColor = json['polymer_sand_color'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['salesman_id'] = this.salesmanId;
//     data['client_id'] = this.clientId;
//     data['superficie'] = this.superficie;
//     data['nouvelle_infra'] = this.nouvelleInfra;
//     data['positionnement'] = this.positionnement;
//     data['type_of_waste'] = this.typeOfWaste;
//     data['pouces_asphalte'] = this.poucesAsphalte;
//     data['contour_en_pave'] = this.contourEnPave;
//     data['type_of_plain_pavers'] = this.typeOfPlainPavers;
//     data['paver_color'] = this.paverColor;
//     data['polymer_sand_color'] = this.polymerSandColor;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class PlatesBandesData {
//   int? id;
//   int? salesmanId;
//   int? clientId;
//   int? superficie;
//   int? profondeur;
//   int? perimeter;
//   String? positionnement;
//   String? finition;
//   String? couleurFinition;
//   int? combienDePouces;
//   String? bordure;
//   String? couleur;
//   String? plantation;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   PlatesBandesData(
//       {this.id,
//         this.salesmanId,
//         this.clientId,
//         this.superficie,
//         this.profondeur,
//         this.perimeter,
//         this.positionnement,
//         this.finition,
//         this.couleurFinition,
//         this.combienDePouces,
//         this.bordure,
//         this.couleur,
//         this.plantation,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   PlatesBandesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     salesmanId = json['salesman_id'];
//     clientId = json['client_id'];
//     superficie = json['superficie'];
//     profondeur = json['profondeur'];
//     perimeter = json['perimeter'];
//     positionnement = json['positionnement'];
//     finition = json['finition'];
//     couleurFinition = json['couleur_finition'];
//     combienDePouces = json['combien_de_pouces'];
//     bordure = json['bordure'];
//     couleur = json['couleur'];
//     plantation = json['plantation'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['salesman_id'] = this.salesmanId;
//     data['client_id'] = this.clientId;
//     data['superficie'] = this.superficie;
//     data['profondeur'] = this.profondeur;
//     data['perimeter'] = this.perimeter;
//     data['positionnement'] = this.positionnement;
//     data['finition'] = this.finition;
//     data['couleur_finition'] = this.couleurFinition;
//     data['combien_de_pouces'] = this.combienDePouces;
//     data['bordure'] = this.bordure;
//     data['couleur'] = this.couleur;
//     data['plantation'] = this.plantation;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class MuretData {
//   int? id;
//   int? clientId;
//   int? salesmanId;
//   double? superficie;
//   double? hauteur;
//   double? linearFeet;
//   String? positionnement;
//   String? typeOfWaste;
//   String? paverColor;
//   String? couronnement;
//   String? couleurDuCouronnement;
//   String? infrastructure;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   MuretData(
//       {this.id,
//         this.clientId,
//         this.salesmanId,
//         this.superficie,
//         this.hauteur,
//         this.linearFeet,
//         this.positionnement,
//         this.typeOfWaste,
//         this.paverColor,
//         this.couronnement,
//         this.couleurDuCouronnement,
//         this.infrastructure,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   MuretData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     clientId = json['client_id'];
//     salesmanId = json['salesman_id'];
//     superficie = json['superficie'];
//     hauteur = json['hauteur'];
//     linearFeet = json['linear_feet'];
//     positionnement = json['positionnement'];
//     typeOfWaste = json['type_of_waste'];
//     paverColor = json['paver_color'];
//     couronnement = json['couronnement'];
//     couleurDuCouronnement = json['couleur_du_couronnement'];
//     infrastructure = json['infrastructure'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['client_id'] = this.clientId;
//     data['salesman_id'] = this.salesmanId;
//     data['superficie'] = this.superficie;
//     data['hauteur'] = this.hauteur;
//     data['linear_feet'] = this.linearFeet;
//     data['positionnement'] = this.positionnement;
//     data['type_of_waste'] = this.typeOfWaste;
//     data['paver_color'] = this.paverColor;
//     data['couronnement'] = this.couronnement;
//     data['couleur_du_couronnement'] = this.couleurDuCouronnement;
//     data['infrastructure'] = this.infrastructure;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class DrainData {
//   int? id;
//   int? clientId;
//   int? salesmanId;
//   String? typeDeDrain;
//   int? longeur;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   DrainData(
//       {this.id,
//         this.clientId,
//         this.salesmanId,
//         this.typeDeDrain,
//         this.longeur,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   DrainData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     clientId = json['client_id'];
//     salesmanId = json['salesman_id'];
//     typeDeDrain = json['type_de_drain'];
//     longeur = json['longeur'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['client_id'] = this.clientId;
//     data['salesman_id'] = this.salesmanId;
//     data['type_de_drain'] = this.typeDeDrain;
//     data['longeur'] = this.longeur;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class MargelleData {
//   int? id;
//   int? clientId;
//   int? salesmanId;
//   double? copingQuantity;
//   int? mesure;
//   String? note;
//   String? photoVideo;
//   String? createdAt;
//   String? updatedAt;
//
//   MargelleData(
//       {this.id,
//         this.clientId,
//         this.salesmanId,
//         this.copingQuantity,
//         this.mesure,
//         this.note,
//         this.photoVideo,
//         this.createdAt,
//         this.updatedAt});
//
//   MargelleData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     clientId = json['client_id'];
//     salesmanId = json['salesman_id'];
//     copingQuantity = json['coping_quantity'];
//     mesure = json['mesure'];
//     note = json['note'];
//     photoVideo = json['photo_video'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['client_id'] = this.clientId;
//     data['salesman_id'] = this.salesmanId;
//     data['coping_quantity'] = this.copingQuantity;
//     data['mesure'] = this.mesure;
//     data['note'] = this.note;
//     data['photo_video'] = this.photoVideo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
class DetailsListModel {
  bool? status;
  String? message;
  List<Data>? data;

  DetailsListModel({this.status, this.message, this.data});

  DetailsListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic salesmanId;
  dynamic clientId;
  dynamic superficie;
  dynamic  profondeur;
  dynamic  positionnement;
  dynamic  detourber;
  dynamic  typeDeDechet;
  dynamic  photoVideo;
  dynamic  createdAt;
  dynamic  updatedAt;

  Data(
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
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

