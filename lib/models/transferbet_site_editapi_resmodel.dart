import 'dart:convert';

List<TransferbetSiteEditApiResmodel> transferbetSiteEditApiResmodelFromJson(String str) => List<TransferbetSiteEditApiResmodel>.from(json.decode(str).map((x) => TransferbetSiteEditApiResmodel.fromJson(x)));

String transferbetSiteEditApiResmodelToJson(List<TransferbetSiteEditApiResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferbetSiteEditApiResmodel {
  TransferbetSiteEditApiResmodel({
    this.transferId,
    this.transferNo,
    this.transferDate,
    this.frProjectId,
    this.frSiteId,
    this.toSiteId,
    this.subContId,
    this.frProject,
    this.frSiteName,
    this.toSiteName,
    this.subContName,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.transType,
    this.transferEditDet,
  });

  int? transferId;
  String? transferNo;
  String? transferDate;
  int? frProjectId;
  int? frSiteId;
  int? toSiteId;
  int? subContId;
  String? frProject;
  String? frSiteName;
  String? toSiteName;
  String? subContName;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  int? transType;
  List<TransferEditDet>? transferEditDet;

  factory TransferbetSiteEditApiResmodel.fromJson(Map<String, dynamic> json) => TransferbetSiteEditApiResmodel(
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    transferDate: json["TransferDate"],
    frProjectId: json["FrProjectId"],
    frSiteId: json["FrSiteId"],
    toSiteId: json["ToSiteId"],
    subContId: json["SubContId"],
    frProject: json["FrProject"],
    frSiteName: json["FrSiteName"],
    toSiteName: json["ToSiteName"],
    subContName: json["SubContName"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    transType: json["TransType"],
    transferEditDet: List<TransferEditDet>.from(json["TransferEditDet"].map((x) => TransferEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TransferId": transferId,
    "TransferNo": transferNo,
    "TransferDate": transferDate,
    "FrProjectId": frProjectId,
    "FrSiteId": frSiteId,
    "ToSiteId": toSiteId,
    "SubContId": subContId,
    "FrProject": frProject,
    "FrSiteName": frSiteName,
    "ToSiteName": toSiteName,
    "SubContName": subContName,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "TransType": transType,
    "TransferEditDet": List<dynamic>.from(transferEditDet!.map((x) => x.toJson())),
  };
}

class TransferEditDet {
  TransferEditDet({
    this.materialId,
    this.materialName,
    this.unit,
    this.stockQty,
    this.qty,
    this.rate,
    this.amount,
  });

  int? materialId;
  String? materialName;
  String? unit;
  double? stockQty;
  double? qty;
  double? rate;
  double? amount;

  factory TransferEditDet.fromJson(Map<String, dynamic> json) => TransferEditDet(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    stockQty: json["StockQty"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "StockQty": stockQty,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
  };
}
