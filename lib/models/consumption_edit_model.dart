// To parse this JSON data, do
//
//     final conumEditResponse = conumEditResponseFromJson(jsonString);

import 'dart:convert';

List<ConumEditResponse> conumEditResponseFromJson(String str) => List<ConumEditResponse>.from(json.decode(str).map((x) => ConumEditResponse.fromJson(x)));

String conumEditResponseToJson(List<ConumEditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConumEditResponse {
  ConumEditResponse({
    this.usageId,
    this.usageNo,
    this.usageDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.usageType,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.usageEditDet,
  });

  int? usageId;
  String? usageNo;
  String? usageDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? projectName;
  String? siteName;
  String? subContName;
  String? usageType;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  int? userId;
  String? entryMode;
  List<UsageEditDet>? usageEditDet;

  factory ConumEditResponse.fromJson(Map<String, dynamic> json) => ConumEditResponse(
    usageId: json["UsageId"],
    usageNo: json["UsageNo"],
    usageDate: json["UsageDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    usageType: json["UsageType"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    usageEditDet: List<UsageEditDet>.from(json["UsageEditDet"].map((x) => UsageEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UsageId": usageId,
    "UsageNo": usageNo,
    "UsageDate": usageDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "UsageType": usageType,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "UsageEditDet": List<dynamic>.from(usageEditDet!.map((x) => x.toJson())),
  };
}

class UsageEditDet {
  UsageEditDet({
    this.materialId,
    this.materialName,
    this.unit,
    this.stockQty,
    this.qty,
  });

  int? materialId;
  String? materialName;
  String? unit;
  double? stockQty;
  double? qty;

  factory UsageEditDet.fromJson(Map<String, dynamic> json) => UsageEditDet(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    stockQty: json["StockQty"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "StockQty": stockQty,
    "Qty": qty,
  };
}
