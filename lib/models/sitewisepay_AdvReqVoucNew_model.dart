// To parse this JSON data, do
//
//     final sitewisePaymentList = sitewisePaymentListFromJson(jsonString);

import 'dart:convert';

List<SitewisePaymentList> sitewisePaymentListFromJson(String str) => List<SitewisePaymentList>.from(json.decode(str).map((x) => SitewisePaymentList.fromJson(x)));

String sitewisePaymentListToJson(List<SitewisePaymentList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SitewisePaymentList {
  int? purOrdMasId;
  String? orderNo;
  String? siteName;
  int? siteid;
  String? project;
  int? projectid;
  double? netamt;
  double? advanceAmt;
  double? bAmount;
  double? amount;
  double? tdsper;
  double? tdsamt;
  double? totamt;

  SitewisePaymentList({
    this.purOrdMasId,
    this.orderNo,
    this.siteName,
    this.siteid,
    this.project,
    this.projectid,
    this.netamt,
    this.advanceAmt,
    this.bAmount,
    this.amount,
    this.tdsper,
    this.tdsamt,
    this.totamt,
  });

  factory SitewisePaymentList.fromJson(Map<String, dynamic> json) => SitewisePaymentList(
    purOrdMasId: json["Pur_ord_mas_id"],
    orderNo: json["PoNo"],
    siteName: json["siteName"] ?? json["SiteName"],
    siteid: json["siteId"] ?? json["siteid"],
    project: json["Project"],
    projectid: json["Projectid"],
    netamt: json["netamt"],
    advanceAmt: json["advanceAmt"] ?? json["AdvanceAmt"],
    bAmount: json["BAmount"],
    amount: json["Amount"],
    tdsper: json["tdsper"],
    tdsamt: json["tdsamt"],
    totamt: json["totamt"],
  );

  Map<String, dynamic> toJson() => {
    "Pur_ord_mas_id": purOrdMasId,
    "PoNo": orderNo,
    "siteName": siteName,
    "siteId": siteid,
    "Project": project,
    "Projectid": projectid,
    "netamt": netamt,
    "advanceAmt": advanceAmt,
    "BAmount": bAmount,
    "Amount": amount,
    "tdsper": tdsper,
    "tdsamt": tdsamt,
    "totamt": totamt,
  };
}
