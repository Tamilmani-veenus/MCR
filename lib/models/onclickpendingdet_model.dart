

import 'dart:convert';

List<OnclickPendingDet> onclickPendingDetFromJson(String str) => List<OnclickPendingDet>.from(json.decode(str).map((x) => OnclickPendingDet.fromJson(x)));

String onclickPendingDetToJson(List<OnclickPendingDet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnclickPendingDet {
  OnclickPendingDet({
    this.materialName,
    this.materialID,
    this.scale,
    this.qty,
    this.poQty,
    this.balQty,
    this.PORate,
    this.PoAmt,
    this.GSTPer,
    this.GSTAmt,
    this.NetAmt,
    this.grnQty,
    this.remarks,
    this.transQty,
    this.ackQty,
    this.frProjectName,
    this.preAppType,
  });

  String? materialName;
  int? materialID;
  String? scale;
  double? qty;
  double? poQty;
  double? balQty;
  double? PORate;
  double? PoAmt;
  double? GSTPer;
  double? GSTAmt;
  double? NetAmt;
  double? grnQty;
  String? remarks;
  double? transQty;
  double? ackQty;
  String? frProjectName;
  String? preAppType;

  factory OnclickPendingDet.fromJson(Map<String, dynamic> json) => OnclickPendingDet(
    materialName: json["MaterialName"],
    materialID: json["Materialid"],
    scale: json["Scale"],
    qty: json["Qty"],
    poQty: json["POQty"],
    balQty: json["BalQty"],
    PORate: json["PORate"],
    PoAmt: json["POAmt"],
    GSTPer: json["GSTPer"],
    GSTAmt: json["GSTAmt"],
    NetAmt: json["NetAmt"],
    grnQty: json["GRNQty"],
    remarks: json["Remarks"],
    transQty: json["TransQty"],
    ackQty: json["AckQty"],
    frProjectName: json["FrProjectName"],
    preAppType: json["PreAppType"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialName": materialName,
    "Materialid": materialID,
    "Scale": scale,
    "Qty": qty,
    "POQty": poQty,
    "BalQty": balQty,
    "PORate": PORate,
    "POAmt": PoAmt,
    "GSTPer": GSTPer,
    "GSTAmt": GSTAmt,
    "NetAmt": NetAmt,
    "GRNQty": grnQty,
    "Remarks": remarks,
    "TransQty": transQty,
    "AckQty": ackQty,
    "FrProjectName": frProjectName,
    "PreAppType": preAppType,
  };
}
