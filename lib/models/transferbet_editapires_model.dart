import 'dart:convert';

List<TransferbetEditApiRes> transferbetEditApiResFromJson(String str) => List<TransferbetEditApiRes>.from(json.decode(str).map((x) => TransferbetEditApiRes.fromJson(x)));

String transferbetEditApiResToJson(List<TransferbetEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferbetEditApiRes {
  TransferbetEditApiRes({
    this.transferId,
    this.transferNo,
    this.transferDate,
    this.reqordNo,
    this.reqId,
    this.frProjectId,
    this.frSiteId,
    this.toProjectId,
    this.frProjectName,
    this.frSiteName,
    this.toProjectName,
    this.transTypeName,
    this.transType,
    this.vechileNo,
    this.driverName,
    this.transAmt,
    this.totAmt,
    this.dcNo,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.transferEditDet,
  });

  int? transferId;
  String? transferNo;
  String? transferDate;
  String? reqordNo;
  int? reqId;
  int? frProjectId;
  int? frSiteId;
  int? toProjectId;
  String? frProjectName;
  String? frSiteName;
  String? toProjectName;
  String? transTypeName;
  String? transType;
  String? vechileNo;
  String? driverName;
  double? transAmt;
  double? totAmt;
  String? dcNo;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  List<TransferEditDet>? transferEditDet;

  factory TransferbetEditApiRes.fromJson(Map<String, dynamic> json) => TransferbetEditApiRes(
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    reqordNo: json["ReqordNo"],
    reqId: json["ReqId"],
    transferDate: json["TransferDate"],
    frProjectId: json["FrProjectId"],
    frSiteId: json["FrSiteId"],
    toProjectId: json["ToProjectId"],
    frProjectName: json["FrProjectName"],
    frSiteName: json["FrSiteName"],
    toProjectName: json["ToProjectName"],
    transTypeName: json["TransTypeName"],
    transType: json["TransType"],
    vechileNo: json["VechileNo"],
    driverName: json["DriverName"],
    transAmt: json["TransAmt"],
    totAmt: json["TotAmt"],
    dcNo: json["DCNo"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    transferEditDet: List<TransferEditDet>.from(json["TransferEditDet"].map((x) => TransferEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TransferId": transferId,
    "TransferNo": transferNo,
    "TransferDate": transferDate,
    "ReqordNo": reqordNo,
    "ReqId": reqId,
    "FrProjectId": frProjectId,
    "FrSiteId": frSiteId,
    "ToProjectId": toProjectId,
    "FrProjectName": frProjectName,
    "FrSiteName": frSiteName,
    "ToProjectName": toProjectName,
    "TransTypeName": transTypeName,
    "TransType": transType,
    "VechileNo": vechileNo,
    "DriverName": driverName,
    "TransAmt": transAmt,
    "TotAmt": totAmt,
    "DCNo": dcNo,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
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
    this.balQty,
    this.rate,
    this.amount,
    this.reqDetId,
  });

  int? materialId;
  String? materialName;
  String? unit;
 double? stockQty;
 double? qty;
 double? balQty;
 double? rate;
 double? amount;
  int? reqDetId;

  factory TransferEditDet.fromJson(Map<String, dynamic> json) => TransferEditDet(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    stockQty: json["StockQty"],
    qty: json["Qty"],
    balQty: json["BalQty"],
    rate: json["Rate"],
    amount: json["Amount"],
    reqDetId: json["ReqDetId"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "StockQty": stockQty,
    "Qty": qty,
    "BalQty": balQty,
    "Rate": rate,
    "Amount": amount,
    "ReqDetId": reqDetId,
  };
}
