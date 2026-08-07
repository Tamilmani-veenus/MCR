import 'dart:convert';

TransferbetSiteSaveApiReq transferbetSiteSaveApiReqFromJson(String str) => TransferbetSiteSaveApiReq.fromJson(json.decode(str));

String transferbetSiteSaveApiReqToJson(TransferbetSiteSaveApiReq data) => json.encode(data.toJson());

class TransferbetSiteSaveApiReq {
  TransferbetSiteSaveApiReq({
    this.transferId,
    this.transferNo,
    this.transferDate,
    this.frProjectId,
    this.frSiteId,
    this.toSiteId,
    this.subContId,
    this.transType,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
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
  String? toSiteId;
  String? subContId;
  String? transType;
  String? remarks;
  String? preparedby;
  String? preparedbyName;
  String? userId;
  String? entryMode;
  String? deviceName;
  List<TransferDet>? transferDet;

  factory TransferbetSiteSaveApiReq.fromJson(Map<String, dynamic> json) => TransferbetSiteSaveApiReq(
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    transferDate: json["TransferDate"],
    frProjectId: json["FrProjectId"],
    frSiteId: json["FrSiteId"],
    toSiteId: json["ToSiteId"],
    subContId: json["SubContId"],
    transType: json["TransType"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
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
    "ToSiteId": toSiteId,
    "SubContId": subContId,
    "TransType": transType,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "TransferDet": List<dynamic>.from(transferDet!.map((x) => x.toJson())),
  };
}

class TransferDet {
  TransferDet({
    this.materialId,
    this.qty,
    this.rate,
    this.amount,
    this.detRemarks,
  });

  String? materialId;
  String? qty;
  String? rate;
  String? amount;
  String? detRemarks;

  factory TransferDet.fromJson(Map<String, dynamic> json) => TransferDet(
    materialId: json["MaterialId"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "DetRemarks": detRemarks,
  };
}
