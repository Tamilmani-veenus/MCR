// To parse this JSON data, do
//
//     final billDirectWorkOrdDet = billDirectWorkOrdDetFromJson(jsonString);

import 'dart:convert';

List<BillDirectWorkOrdDet> billDirectWorkOrdDetFromJson(String str) => List<BillDirectWorkOrdDet>.from(json.decode(str).map((x) => BillDirectWorkOrdDet.fromJson(x)));

String billDirectWorkOrdDetToJson(List<BillDirectWorkOrdDet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillDirectWorkOrdDet {
  int? headItemId;
  int? subItemId;
  String? boqcode;
  String? itemCode;
  String? itemdesc;
  String? unit;
  double? rate;
  double? curBillQty;
  double? amt1;
  int? level3ItemId;
  int? siteId;
  String? sIteName;
  int? dworkDet_id;
  double? qty;
  double? balbillqty;
  double? totalqty;
  double? amount;

  BillDirectWorkOrdDet({
    this.headItemId,
    this.subItemId,
    this.boqcode,
    this.itemCode,
    this.itemdesc,
    this.unit,
    this.rate,
    this.curBillQty,
    this.amt1,
    this.level3ItemId,
    this.siteId,
    this.sIteName,
    this.dworkDet_id,
    this.qty,
    this.balbillqty,
    this.totalqty,
    this.amount,
  });

  factory BillDirectWorkOrdDet.fromJson(Map<String, dynamic> json) => BillDirectWorkOrdDet(
    headItemId: json["HeadItem_id"],
    subItemId: json["SubItem_id"],
    boqcode: json["boqcode"],
    itemCode: json["ItemCode"],
    itemdesc: json["itemdesc"],
    unit: json["Unit"],
    rate: json["Rate"],
    curBillQty: json["CurBillQty"],
    amt1: json["Amt1"],
    level3ItemId: json["Level3item_id"],
    siteId: json["SiteId"],
    sIteName: json["SIteName"],
    dworkDet_id: json["dworkDet_id"],
    qty: json["qty"],
    balbillqty: json["balbillqty"],
    totalqty: json["Totalqty"],
    amount: json["Amt"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItem_id": headItemId,
    "SubItem_id": subItemId,
    "boqcode": boqcode,
    "ItemCode": itemCode,
    "itemdesc": itemdesc,
    "Unit": unit,
    "Rate": rate,
    "CurBillQty": curBillQty,
    "Amt1": amt1,
    "Level3item_id": level3ItemId,
    "SiteId": siteId,
    "SIteName": sIteName,
    "dworkDet_id": dworkDet_id,
    "qty": qty,
    "balbillqty": balbillqty,
    "Totalqty": totalqty,
    "Amt": amount,
  };
}
