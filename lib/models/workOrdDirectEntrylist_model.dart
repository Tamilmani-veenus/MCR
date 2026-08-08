// To parse this JSON data, do
//
//     final workOrdDirectModel = workOrdDirectModelFromJson(jsonString);

import 'dart:convert';

List<WorkOrdDirectModel> workOrdDirectModelFromJson(String str) => List<WorkOrdDirectModel>.from(json.decode(str).map((x) => WorkOrdDirectModel.fromJson(x)));

String workOrdDirectModelToJson(List<WorkOrdDirectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkOrdDirectModel {
  int? workOrderId;
  String? workOrderNo;
  String? entryDate;
  int? projectId;
  String? project;
  int? siteId;
  String? siteName;
  int? subContId;
  String? subconName;
  double? netAmt;
  int? preparedBy;
  String? preparedByName;
  String? appStatus;
  String? status;

  WorkOrdDirectModel({
    this.workOrderId,
    this.workOrderNo,
    this.entryDate,
    this.projectId,
    this.project,
    this.siteId,
    this.siteName,
    this.subContId,
    this.subconName,
    this.netAmt,
    this.preparedBy,
    this.preparedByName,
    this.appStatus,
    this.status,
  });

  factory WorkOrdDirectModel.fromJson(Map<String, dynamic> json) => WorkOrdDirectModel(
    workOrderId: json["Work_OrderId"],
    workOrderNo: json["WorkOrderNo"],
    entryDate: json["EntryDate"],
    projectId: json["ProjectId"],
    project: json["Project"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    subContId: json["SubContId"],
    subconName: json["Subcon_Name"],
    netAmt: json["NetAmt"],
    preparedBy: json["PreparedBy"],
    preparedByName: json["PreparedByName"],
    appStatus: json["AppStatus"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Work_OrderId": workOrderId,
    "WorkOrderNo": workOrderNo,
    "EntryDate": entryDate,
    "ProjectId": projectId,
    "Project": project,
    "SiteId": siteId,
    "SiteName": siteName,
    "SubContId": subContId,
    "Subcon_Name": subconName,
    "NetAmt": netAmt,
    "PreparedBy": preparedBy,
    "PreparedByName": preparedByName,
    "AppStatus": appStatus,
    "Status": status,
  };
}
