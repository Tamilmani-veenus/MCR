// To parse this JSON data, do
//
//     final nmrItemlist = nmrItemlistFromJson(jsonString);

import 'dart:convert';

List<NmrItemlist> nmrItemlistFromJson(String str) => List<NmrItemlist>.from(json.decode(str).map((x) => NmrItemlist.fromJson(x)));

String nmrItemlistToJson(List<NmrItemlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NmrItemlist {
  NmrItemlist({
    this.project,
    this.projectid,
    this.sitename,
    this.siteId,
    this.categoryId,
    this.categoryName,
    this.nmrAmt,
    this.totnos,
    this.totalOtamt,
    this.netAmt,
  });

  String? project;
  int? projectid;
  String? sitename;
  int? siteId;
  int? categoryId;
  String? categoryName;
  double? nmrAmt;
  double? totnos;
  double? totalOtamt;
  double? netAmt;

  factory NmrItemlist.fromJson(Map<String, dynamic> json) => NmrItemlist(
    project: json["project"],
    projectid: json["projectid"],
    sitename: json["sitename"],
    siteId: json["siteid"],
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    nmrAmt: json["NMRAMT"],
    totnos: json["totnos"],
    totalOtamt: json["total_otamt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "project": project,
    "projectid": projectid,
    "sitename": sitename,
    "siteid": siteId,
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "NMRAMT": nmrAmt,
    "totnos": totnos,
    "total_otamt": totalOtamt,
    "NetAmt": netAmt,
  };
}
