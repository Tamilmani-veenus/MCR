// To parse this JSON data, do
//
//     final attendanceEntrylist = attendanceEntrylistFromJson(jsonString);

import 'dart:convert';

List<SubContAttendanceEntrylistRes> subContattendanceEntrylistFromJson(String str) => List<SubContAttendanceEntrylistRes>.from(json.decode(str).map((x) => SubContAttendanceEntrylistRes.fromJson(x)));

String subContattendanceEntrylistToJson(List<SubContAttendanceEntrylistRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubContAttendanceEntrylistRes {
  SubContAttendanceEntrylistRes({
    this.subcontLabrAttnId,
    this.labrAttnNo,
    this.labrAttnDate,
    this.totNos,
    this.totAmt,
    this.workType,
    this.workshift,
    this.project,
    this.subcontid,
    this.subconName,
    this.siteId,
    this.siteName,
    this.preparedByName,
  });

  int? subcontLabrAttnId;
  String? labrAttnNo;
  String? labrAttnDate;
  double? totNos;
  double? totAmt;
  String? workType;
  String? workshift;
  String? project;
  int? subcontid;
  int? siteId;
  String? siteName;
  String? subconName;
  String? preparedByName;

  factory SubContAttendanceEntrylistRes.fromJson(Map<String, dynamic> json) => SubContAttendanceEntrylistRes(
    subcontLabrAttnId: json["Subcont_LabrAttn_Id"],
    labrAttnNo: json["LabrAttn_No"],
    labrAttnDate: json["LabrAttn_Date"],
    totNos: json["TotNos"].toDouble(),
    totAmt: json["TotAmt"].toDouble(),
    workType: json["WorkType"],
    workshift: json["workshift"],
    project: json["project"],
    subcontid: json["subcontid"],
    subconName: json["Subcon_name"],
    siteId: json["Siteid"],
    siteName: json["SiteName"],
    preparedByName: json["PreparedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Subcont_LabrAttn_Id": subcontLabrAttnId,
    "LabrAttn_No": labrAttnNo,
    "LabrAttn_Date": labrAttnDate,
    "TotNos": totNos,
    "TotAmt": totAmt,
    "WorkType":  workType,
    "workshift":  workshift,
    "project": project,
    "subcontid": subcontid,
    "Subcon_name": subconName,
    "Siteid": siteId,
    "SiteName": siteName,
    "PreparedByName": preparedByName,
  };
}

