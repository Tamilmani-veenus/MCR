// To parse this JSON data, do
//
//     final materiallistResponse = materiallistResponseFromJson(jsonString);

import 'dart:convert';

List<MateriallistResponse> materiallistResponseFromJson(String str) => List<MateriallistResponse>.from(json.decode(str).map((x) => MateriallistResponse.fromJson(x)));

String materiallistResponseToJson(List<MateriallistResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MateriallistResponse {
  MateriallistResponse({
    this.materialId,
    this.material,
    this.scale,
    this.fixQty,
    this.reqQty,
    this.addQty,
    this.lessQty,
    this.balqty,
  });

  int? materialId;
  String? material;
  String? scale;
  double? fixQty;
  double? reqQty;
  double? addQty;
  double? lessQty;
  double? balqty;
  String? nos='1';
  bool? isCheck = false;

  factory MateriallistResponse.fromJson(Map<String, dynamic> json) => MateriallistResponse(
    materialId: json["MaterialId"],
    material: json["MaterialName"],
    scale: json["Scale"],
    fixQty: json["FixQty"],
    reqQty: json["ReqQty"],
    addQty: json["addQty"],
    lessQty: json["lessQty"],
    balqty: json["BalQty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": material,
    "Scale": scale,
    "FixQty": fixQty,
    "ReqQty": reqQty,
    "addQty": addQty,
    "lessQty": lessQty,
    "BalQty": balqty,
  };
}