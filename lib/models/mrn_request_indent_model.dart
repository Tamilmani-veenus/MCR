// To parse this JSON data, do
//
//     final mrNentrylist = mrNentrylistFromJson(jsonString);

import 'dart:convert';

List<MrNentrylist> mrNentrylistFromJson(String str) => List<MrNentrylist>.from(json.decode(str).map((x) => MrNentrylist.fromJson(x)));

String mrNentrylistToJson(List<MrNentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MrNentrylist {
  MrNentrylist({
    this.reqMasId,
    this.projectid,
    this.siteid,
    this.reqOrdNo,
    this.reqOrdDate1,
    this.reqOrdDate,
    this.reqDueDate,
    this.project,
    this.sitename,
    this.Preparedby,
  });

  int? reqMasId;
  int? projectid;
  int? siteid;
  String? reqOrdNo;
  String? reqOrdDate1;
  String? reqOrdDate;
  String? reqDueDate;
  String? project;
  String? sitename;
  String? Preparedby;

  factory MrNentrylist.fromJson(Map<String, dynamic> json) => MrNentrylist(
    reqMasId: json["req_mas_id"],
    projectid: json["projectid"],
    siteid: json["siteid"],
    reqOrdNo: json["req_ord_No"],
    reqOrdDate1: json["req_ord_date1"],
    reqOrdDate: json["req_ord_date"],
    reqDueDate: json["req_due_date"],
    project: json["Project"],
    sitename: json["Sitename"],
    Preparedby: json["Preparedby"],
  );

  Map<String, dynamic> toJson() => {
    "req_mas_id": reqMasId,
    "projectid": projectid,
    "projectid": projectid,
    "siteid": siteid,
    "Sitename": sitename,
    "req_ord_No": reqOrdNo,
    "req_ord_date1": reqOrdDate1,
    "req_ord_date": reqOrdDate,
    "req_due_date": reqDueDate,
    "Project": project,
    "Preparedby": Preparedby,
  };
}
