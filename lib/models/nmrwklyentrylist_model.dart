

import 'dart:convert';

List<NmrEntrylist> nmrEntrylistFromJson(String str) => List<NmrEntrylist>.from(json.decode(str).map((x) => NmrEntrylist.fromJson(x)));

String nmrEntrylistToJson(List<NmrEntrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NmrEntrylist {
  NmrEntrylist({
    this.nmrWorkId,
    this.workNo,
    this.entrydate,
    this.fromDate,
    this.toDate,
    this.subcontid,
    this.subconName,
    this.projectid,
    this.project,
    this.siteName,
    this.totalAmount,
    this.appStatus,
    this.nmrEntrylistAppStatus,
  });

  int? nmrWorkId;
  String? workNo;
  String? entrydate;
  String? fromDate;
  String? toDate;
  int? subcontid;
  String? subconName;
  int? projectid;
  String? project;
  String? siteName;
  double? totalAmount;
  String? appStatus;
  String? nmrEntrylistAppStatus;

  factory NmrEntrylist.fromJson(Map<String, dynamic> json) => NmrEntrylist(
    nmrWorkId: json["NMR_Work_id"],
    workNo: json["Work_No"],
    entrydate: json["Entrydate"],
    fromDate: json["From_Date"],
    toDate:  json["To_Date"] ,
    subcontid: json["subcontid"],
    subconName: json["Subcon_name"],
    projectid: json["projectid"],
    project: json["project"],
    siteName:  json["SiteName"] ,
    totalAmount: json["TotalAmount"],
    appStatus:  json["AppStatus"] ,
    nmrEntrylistAppStatus:  json["app_status"] ,
  );

  Map<String, dynamic> toJson() => {
    "NMR_Work_id": nmrWorkId,
    "Work_No": workNo,
    "Entrydate": entrydate,
    "From_Date": fromDate ,
    "To_Date":  toDate ,
    "subcontid": subcontid,
    "Subcon_name": subconName,
    "projectid": projectid,
    "project": project,
    "SiteName":  siteName,
    "TotalAmount": totalAmount,
    "AppStatus":  appStatus,
    "app_status":  nmrEntrylistAppStatus,
  };
}