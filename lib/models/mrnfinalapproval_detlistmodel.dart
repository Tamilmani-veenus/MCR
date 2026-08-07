import 'dart:convert';

List<MrnfinalapprovalDetResModel> mrnfinalapprovalDetResModelFromJson(String str) => json.decode(str) == null ? [] : List<MrnfinalapprovalDetResModel>.from(json.decode(str).map((x) => MrnfinalapprovalDetResModel.fromJson(x)));

String mrnfinalapprovalDetResModelToJson(List<MrnfinalapprovalDetResModel> data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class MrnfinalapprovalDetResModel {
  MrnfinalapprovalDetResModel({
    this.reqMasDetId,
    this.siteName,
    this.material,
    this.reqQty,
    this.qty,
    this.scale,
    this.estQty,
    this.balQty,
    this.type,
    this.refProjectid,
    this.project,
    this.appType,
    this.materialid,
    this.remarks,
    this.description,
    this.stockQty,
    this.refProjectName,
  });

  int? reqMasDetId;
  String? siteName;
  String? material;
  double? reqQty;
  double? qty;
  String? scale;
  double? estQty;
  double? balQty;
  String? type;
  int? refProjectid;
  String? project;
  String? appType;
  int? materialid;
  String? remarks;
  String? description;
  double? stockQty;
  String? refProjectName;

  factory MrnfinalapprovalDetResModel.fromJson(Map<String, dynamic> json) => MrnfinalapprovalDetResModel(
    reqMasDetId: json["req_mas_det_id"],
    siteName: json["SiteName"],
    material: json["Material"],
    reqQty: json["req_qty"],
    qty: json["qty"],
    scale: json["Scale"],
    estQty: json["EstQty"],
    balQty: json["BalQty"],
    type: json["type"],
    refProjectid: json["Ref_Projectid"],
    project: json["Project"],
    appType: json["app_type"],
    materialid: json["Materialid"],
    remarks: json["remarks"],
    description: json["Description"],
    stockQty: json["stock_qty"],
    refProjectName: json["Ref_ProjectName"],
  );

  Map<String, dynamic> toJson() => {
    "req_mas_det_id": reqMasDetId,
    "SiteName": siteName,
    "Material": material,
    "req_qty": reqQty,
    "qty": qty,
    "Scale": scale,
    "EstQty": estQty,
    "BalQty": balQty,
    "type": type,
    "Ref_Projectid": refProjectid,
    "Project": project,
    "app_type": appType,
    "Materialid": materialid,
    "remarks": remarks,
    "Description": description,
    "stock_qty": stockQty,
    "Ref_ProjectName": refProjectName,
  };
}
