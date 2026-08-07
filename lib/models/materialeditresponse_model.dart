// To parse this JSON data, do
//
//     final materialeditResponse = materialeditResponseFromJson(jsonString);

import 'dart:convert';

List<MaterialeditResponse> materialeditResponseFromJson(String str) => List<MaterialeditResponse>.from(json.decode(str).map((x) => MaterialeditResponse.fromJson(x)));

String materialeditResponseToJson(List<MaterialeditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialeditResponse {
  MaterialeditResponse({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.reqDueDate,
    this.projectId,
    this.siteId,
    this.projectName,
    this.siteName,
    this.reqRemarks,
    this.preparedby,
    this.preparedbyName,
    this.purchaseType,
    this.PurchaseTypeName,
    this.requestDet,
  });

  int? reqId;
  String? reqNo;
  String? reqDate;
  String? reqDueDate;
  int? projectId;
  int? siteId;
  String? projectName;
  String? siteName;
  String? reqRemarks;
  int? preparedby;
  String? preparedbyName;
  String? purchaseType;
  String? PurchaseTypeName;
  List<RequestDet>? requestDet;

  factory MaterialeditResponse.fromJson(Map<String, dynamic> json) => MaterialeditResponse(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    reqDate: json["ReqDate"],
    reqDueDate: json["ReqDueDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    reqRemarks: json["ReqRemarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    purchaseType: json["PurchaseType"],
    PurchaseTypeName: json["PurchaseTypeName"],
    requestDet: List<RequestDet>.from(json["RequestDet"].map((x) => RequestDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "ReqDate": reqDate,
    "ReqDueDate": reqDueDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "ReqRemarks": reqRemarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "PurchaseType": purchaseType,
    "PurchaseTypeName": PurchaseTypeName,
    "RequestDet": List<dynamic>.from(requestDet!.map((x) => x.toJson())),
  };
}

class RequestDet {
  RequestDet({
    this.reqDetId,
    this.matId,
    this.matName,
    this.scale,
    this.qty,
    this.balqty,
    this.detRemarks,
    this.detDescription,
  });

  int? reqDetId;
  int? matId;
  String? matName;
  String? scale;
  double? qty;
  double? balqty;
  String? detRemarks;
  String? detDescription;

  factory RequestDet.fromJson(Map<String, dynamic> json) => RequestDet(
    reqDetId: json["ReqDetId"],
    matId: json["MatId"],
    matName: json["MatName"],
    scale: json["Scale"],
    qty: json["Qty"],
    balqty: json["BalQty"],
    detRemarks: json["DetRemarks"],
    detDescription: json["DetDescription"],
  );

  Map<String, dynamic> toJson() => {
    "ReqDetId": reqDetId,
    "MatId": matId,
    "MatName": matName,
    "Scale": scale,
    "Qty": qty,
    "BalQty": balqty,
    "DetRemarks": detRemarks,
    "DetDescription": detDescription,
  };
}
