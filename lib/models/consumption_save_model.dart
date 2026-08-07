// To parse this JSON data, do
//
//     final conumSaveRequest = conumSaveRequestFromJson(jsonString);

import 'dart:convert';

ConumSaveRequest conumSaveRequestFromJson(String str) => ConumSaveRequest.fromJson(json.decode(str));

String conumSaveRequestToJson(ConumSaveRequest data) => json.encode(data.toJson());

class ConumSaveRequest {
  ConumSaveRequest({
    this.usageId,
    this.usageNo,
    this.usageDate,
    this.projectId,
    this.SubContId,
    this.siteId,
    this.usageType,
    this.remarks,
    this.preparedby,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.usageDet,
  });
  String? usageId;
  String? usageNo;
  String? usageDate;
  String? projectId;
  String? SubContId;
  String? siteId;
  String? usageType;
  String? remarks;
  String? preparedby;
  String? userId;
  String? deviceName;
  String? entryMode;
  List<UsageDet>? usageDet;

  factory ConumSaveRequest.fromJson(Map<String, dynamic> json) => ConumSaveRequest(
    usageId:json["UsageId"],
    usageNo: json["UsageNo"],
    usageDate: json["UsageDate"],
    projectId: json["ProjectId"],
    SubContId: json["SubContId"],
    siteId: json["SiteId"],
    usageType: json["UsageType"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    usageDet: List<UsageDet>.from(json["UsageDet"].map((x) => UsageDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UsageId": usageId,
    "UsageNo": usageNo,
    "UsageDate": usageDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "UsageType": usageType,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "UserId": userId,
    "DeviceName": deviceName,
    "SubContId": SubContId,
    "EntryMode": entryMode,
    "UsageDet": List<dynamic>.from(usageDet!.map((x) => x.toJson())),
  };
}

class UsageDet {
  UsageDet({
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

  factory UsageDet.fromJson(Map<String, dynamic> json) => UsageDet(
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
