// To parse this JSON data, do
//
//     final stockwisematerialwise = stockwisematerialwiseFromJson(jsonString);

import 'dart:convert';

List<Stockwisematerialwise> stockwisematerialwiseFromJson(String str) => List<Stockwisematerialwise>.from(json.decode(str).map((x) => Stockwisematerialwise.fromJson(x)));

String stockwisematerialwiseToJson(List<Stockwisematerialwise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stockwisematerialwise {
  int? projectid;
  int? siteid;
  String? projectName;
  String? siteName;
  int? materialid;
  String? itemName;
  String? unit;
  double? balQty;
  double? stockQty;
  String? lastDate;
  String? idleDays;

  Stockwisematerialwise({
    this.projectid,
    this.siteid,
    this.projectName,
    this.siteName,
    this.materialid,
    this.itemName,
    this.unit,
    this.balQty,
    this.stockQty,
    this.lastDate,
    this.idleDays,
  });

  factory Stockwisematerialwise.fromJson(Map<String, dynamic> json) => Stockwisematerialwise(
    projectid: json["projectid"],
    siteid: json["siteid"],
    projectName: json["Project_Name"],
    siteName: json["SiteName"],
    materialid: json["materialid"],
    itemName: json["Item_Name"],
    unit: json["Unit"],
    balQty: json["Bal_Qty"],
    stockQty: json["Stock_Qty"],
    lastDate: json["LastDate"],
    idleDays: json["IdleDays"],
  );

  Map<String, dynamic> toJson() => {
    "projectid": projectid,
    "siteid": siteid,
    "Project_Name": projectName,
    "SiteName": siteName,
    "materialid": materialid,
    "Item_Name": itemName,
    "Unit": unit,
    "Bal_Qty": balQty,
    "Stock_Qty": stockQty,
    "LastDate": lastDate,
    "IdleDays": idleDays,
  };
}
