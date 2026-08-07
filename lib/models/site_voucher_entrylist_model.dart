// To parse this JSON data, do
//
//     final sitevoucherentrylist = sitevoucherentrylistFromJson(jsonString);

import 'dart:convert';



List<Sitevocentrylist> sitevoucherentrylistFromJson(String str) => List<Sitevocentrylist>.from(json.decode(str).map((x) => Sitevocentrylist.fromJson(x)));

String sitevoucherentrylistToJson(List<Sitevocentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sitevocentrylist {
  Sitevocentrylist({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.projectName,
    this.accName,
    this.accType,
    this.payFor,
    this.vocDate1,
    this.vocAmt,
  });

  int? vocId;
  String? vocNo;
  String? vocDate;
  String? projectName;
  String? accName;
  String? accType;
  String? payFor;
  String? vocDate1;
  double? vocAmt;

  factory Sitevocentrylist.fromJson(Map<String, dynamic> json) => Sitevocentrylist(
    vocId: json["voc_id"],
    vocNo: json["voc_no"],
    vocDate: json["voc_date"],
    projectName: json["ProjectName"],
    accName: json["acc_name"],
    accType: json["acc_type"],
    payFor: json["pay_for"],
    vocDate1: json["voc_date1"],
    vocAmt: json["voc_amt"],
  );

  Map<String, dynamic> toJson() => {
    "voc_id": vocId,
    "voc_no": vocNo,
    "voc_date": vocDate,
    "ProjectName": projectName,
    "acc_name": accName,
    "acc_type": accType,
    "pay_for": payFor,
    "voc_date1": vocDate1,
    "voc_amt": vocAmt,
  };
}
