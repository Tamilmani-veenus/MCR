import 'dart:convert';

TransferbetSaveApiReq transferbetSaveApiReqFromJson(String str) => TransferbetSaveApiReq.fromJson(json.decode(str));

String transferbetSaveApiReqToJson(TransferbetSaveApiReq data) => json.encode(data.toJson());

class TransferbetSaveApiReq {
  TransferbetSaveApiReq({
    this.transferId,
    this.transferNo,
    this.transferDate,
    this.frProjectId,
    this.frSiteId,
    this.toProjectId,
    this.transType,
    this.reqId,
    this.reqAppId,
    this.vechileNo,
    this.driverName,
    this.transAmt,
    this.totAmt,
    this.dcNo,
    this.remarks,
    this.preparedby,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.transferDet,
  });

  String? transferId;
  String? transferNo;
  String? transferDate;
  String? frProjectId;
  String? frSiteId;
  String? toProjectId;
  String? transType;
  String? reqId;
  String? reqAppId;
  String? vechileNo;
  String? driverName;
  String? transAmt;
  String? totAmt;
  String? dcNo;
  String? remarks;
  String? preparedby;
  String? userId;
  String? entryMode;
  String? deviceName;
  List<TransferDet>? transferDet;

  factory TransferbetSaveApiReq.fromJson(Map<String, dynamic> json) => TransferbetSaveApiReq(
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    transferDate: json["TransferDate"],
    frProjectId: json["FrProjectId"],
    frSiteId: json["FrSiteId"],
    toProjectId: json["ToProjectId"],
    transType: json["TransType"],
    reqId: json["ReqId"],
    reqAppId: json["ReqAppId"],
    vechileNo: json["VechileNo"],
    driverName: json["DriverName"],
    transAmt: json["TransAmt"],
    totAmt: json["TotAmt"],
    dcNo: json["DCNo"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    transferDet: List<TransferDet>.from(json["TransferDet"].map((x) => TransferDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TransferId": transferId,
    "TransferNo": transferNo,
    "TransferDate": transferDate,
    "FrProjectId": frProjectId,
    "FrSiteId": frSiteId,
    "ToProjectId": toProjectId,
    "TransType": transType,
    "ReqId": reqId,
    "ReqAppId": reqAppId,
    "VechileNo": vechileNo,
    "DriverName": driverName,
    "TransAmt": transAmt,
    "TotAmt": totAmt,
    "DCNo": dcNo,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "TransferDet": List<dynamic>.from(transferDet!.map((x) => x.toJson())),
  };
}

class TransferDet {
  TransferDet({
    this.materialId,
    this.stockQty,
    this.qty,
    this.rate,
    this.amount,
    this.reqDetId,
    this.detRemarks,
  });

  String? materialId;
  String? stockQty;
  String? qty;
  String? rate;
  String? amount;
  String? reqDetId;
  String? detRemarks;

  factory TransferDet.fromJson(Map<String, dynamic> json) => TransferDet(
    materialId: json["MaterialId"],
    stockQty: json["StockQty"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    reqDetId: json["ReqDetId"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "StockQty": stockQty,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "ReqDetId": reqDetId,
    "DetRemarks": detRemarks,
  };
}
