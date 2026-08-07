// To parse this JSON data, do
//
//     final materiasaveResponse = materiasaveResponseFromJson(jsonString);

import 'dart:convert';

MateriasaveResponse materiasaveResponseFromJson(String str) => MateriasaveResponse.fromJson(json.decode(str));

String materiasaveResponseToJson(MateriasaveResponse data) => json.encode(data.toJson());

class MateriasaveResponse {
  MateriasaveResponse({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.reqDueDate,
    this.projectId,
    this.preparedBy,
    this.siteId,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.reqRemarks,
    this.requestDet,
    this.Approvedby,
    this.requestPurType,
  });

  String? reqId;
  String? reqNo;
  String? reqDate;
  String? reqDueDate;
  String? projectId;
  String? preparedBy;
  String? siteId;
  String? userId;
  String? entryMode;
  String? deviceName;
  String? reqRemarks;
  String? Approvedby;
  String? requestPurType;
  List<RequestDet>? requestDet;

  factory MateriasaveResponse.fromJson(Map<String, dynamic> json) => MateriasaveResponse(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    reqDate: json["ReqDate"],
    reqDueDate: json["ReqDueDate"],
    projectId: json["ProjectId"],
    preparedBy: json["PreparedBy"],
    siteId: json["SiteId"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    reqRemarks: json["ReqRemarks"],
    Approvedby: json["Approvedby"],
    requestPurType: json["PucrhaseType"],
    requestDet: List<RequestDet>.from(json["RequestDet"].map((x) => RequestDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "ReqDate": reqDate,
    "ReqDueDate": reqDueDate,
    "ProjectId": projectId,
    "PreparedBy": preparedBy,
    "SiteId": siteId,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "ReqRemarks": reqRemarks,
    "Approvedby": Approvedby,
    "PucrhaseType": requestPurType,
    "RequestDet": List<dynamic>.from(requestDet!.map((x) => x.toJson())),
  };
}

class RequestDet {
  RequestDet({
    this.matId,
    this.scale,
    this.qty,
    this.detRemarks,
    this.detDescription,
  });

  String? matId;
  String? scale;
  String? qty;
  String? detRemarks;
  String? detDescription;

  factory RequestDet.fromJson(Map<String, dynamic> json) => RequestDet(
    matId: json["MatId"],
    scale: json["Scale"],
    qty: json["Qty"],
    detRemarks: json["DetRemarks"],
    detDescription: json["DetDescription"],
  );

  Map<String, dynamic> toJson() => {
    "MatId": matId,
    "Scale": scale,
    "Qty": qty,
    "DetRemarks": detRemarks,
    "DetDescription": detDescription,
  };
}
