import 'dart:convert';

List<TransferacknowAlldatasRes> transferacknowAlldatasResFromJson(String str) => List<TransferacknowAlldatasRes>.from(json.decode(str).map((x) => TransferacknowAlldatasRes.fromJson(x)));

String transferacknowAlldatasResToJson(List<TransferacknowAlldatasRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferacknowAlldatasRes {
  TransferacknowAlldatasRes({
    this.transferId,
    this.transferNo,
    this.frProjectId,
    this.frSiteId,
    this.toProjectId,
    this.frProject,
    this.frSiteName,
    this.toProject,
    this.transferDet,
  });

  int? transferId;
  String? transferNo;
  int? frProjectId;
  int? frSiteId;
  int? toProjectId;
  String? frProject;
  String? frSiteName;
  String? toProject;
  List<TransferDet>? transferDet;

  factory TransferacknowAlldatasRes.fromJson(Map<String, dynamic> json) => TransferacknowAlldatasRes(
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    frProjectId: json["FrProjectId"],
    frSiteId: json["FrSiteId"],
    toProjectId: json["ToProjectId"],
    frProject: json["FrProject"],
    frSiteName: json["FrSiteName"],
    toProject: json["ToProject"],
    transferDet: List<TransferDet>.from(json["TransferDet"].map((x) => TransferDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TransferId": transferId,
    "TransferNo": transferNo,
    "FrProjectId": frProjectId,
    "FrSiteId": frSiteId,
    "ToProjectId": toProjectId,
    "FrProject": frProject,
    "FrSiteName": frSiteName,
    "ToProject": toProject,
    "TransferDet": List<dynamic>.from(transferDet!.map((x) => x.toJson())),
  };
}

class TransferDet {
  TransferDet({
    this.transferDetId,
    this.materialId,
    this.materialName,
    this.scale,
    this.transQty,
    this.ackQty,
    this.detRemarks,
  });

  int? transferDetId;
  int? materialId;
  String? materialName;
  String? scale;
  double? transQty;
  double? ackQty;
  String? detRemarks;

  factory TransferDet.fromJson(Map<String, dynamic> json) => TransferDet(
    transferDetId: json["TransferDetId"],
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scale: json["Scale"],
    transQty: json["TransQty"],
    ackQty: json["AckQty"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "TransferDetId": transferDetId,
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Scale": scale,
    "TransQty": transQty,
    "AckQty": ackQty,
    "DetRemarks": detRemarks,
  };
}
