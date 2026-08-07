import 'dart:convert';

TransferAckSaveReq transferAckSaveReqFromJson(String str) => TransferAckSaveReq.fromJson(json.decode(str));

String transferAckSaveReqToJson(TransferAckSaveReq data) => json.encode(data.toJson());

class TransferAckSaveReq {
  TransferAckSaveReq({
    this.ackId,
    this.ackNo,
    this.ackDate,
    this.transferId,
    this.transferNo,
    this.frProjectId,
    this.toProjectId,
    this.toSiteId,
    this.remarks,
    this.preparedby,

    this.userId,
    this.deviceName,
    this.entryMode,
    this.transferAckDet,
  });

  String? ackId;
  String? ackNo;
  String? ackDate;
  String? transferId;
  String? transferNo;
  String? frProjectId;
  String? toProjectId;
  String? toSiteId;
  String? remarks;
  String? preparedby;

  String? userId;
  String? deviceName;
  String? entryMode;
  List<TransferAckDet>? transferAckDet;

  factory TransferAckSaveReq.fromJson(Map<String, dynamic> json) => TransferAckSaveReq(
    ackId: json["AckId"],
    ackNo: json["AckNo"],
    ackDate: json["AckDate"],
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    frProjectId: json["FrProjectId"],
    toProjectId: json["ToProjectId"],
    toSiteId: json["ToSiteId"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],

    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    transferAckDet: List<TransferAckDet>.from(json["TransferAckDet"].map((x) => TransferAckDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AckId": ackId,
    "AckNo": ackNo,
    "AckDate": ackDate,
    "TransferId": transferId,
    "TransferNo": transferNo,
    "FrProjectId": frProjectId,
    "ToProjectId": toProjectId,
    "ToSiteId": toSiteId,
    "Remarks": remarks,
    "Preparedby": preparedby,

    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "TransferAckDet": List<dynamic>.from(transferAckDet!.map((x) => x.toJson())),
  };
}

class TransferAckDet {
  TransferAckDet({
    this.transferDetId,
    this.materialId,
    this.detRemarks,
    this.ackQty,
  });

  String? transferDetId;
  String? materialId;
  String? detRemarks;
  String? ackQty;

  factory TransferAckDet.fromJson(Map<String, dynamic> json) => TransferAckDet(
    transferDetId: json["TransferDetId"],
    materialId: json["MaterialId"],
    detRemarks: json["DetRemarks"],
    ackQty: json["AckQty"],
  );

  Map<String, dynamic> toJson() => {
    "TransferDetId": transferDetId,
    "MaterialId": materialId,
    "DetRemarks": detRemarks,
    "AckQty": ackQty,
  };
}
