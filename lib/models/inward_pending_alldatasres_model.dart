import 'dart:convert';

List<InwardAllDatasaRes> inwardAllDatasaResFromJson(String str) => List<InwardAllDatasaRes>.from(json.decode(str).map((x) => InwardAllDatasaRes.fromJson(x)));

String inwardAllDatasaResToJson(List<InwardAllDatasaRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InwardAllDatasaRes {
  InwardAllDatasaRes({
    this.id,
    this.no,
    this.type,
    this.purType,
    this.supplierid,
    this.projectId,
    this.siteId,
    this.supplier,
    this.project,
    this.siteName,
    this.deviceName,
    this.getPoDet,
  });

  int? id;
  String? no;
  String? type;
  String? purType;
  int? supplierid;
  int? projectId;
  int? siteId;
  String? supplier;
  String? project;
  String? siteName;
  String? deviceName;
  List<GetPoDet>? getPoDet;

  factory InwardAllDatasaRes.fromJson(Map<String, dynamic> json) => InwardAllDatasaRes(
    id: json["Id"],
    no: json["No"],
    type: json["Type"],
    purType: json["PurType"],
    supplierid: json["Supplierid"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    supplier: json["Supplier"],
    project: json["Project"],
    siteName: json["SiteName"],
    deviceName: json["DeviceName"],
    getPoDet: List<GetPoDet>.from(json["GetPODet"].map((x) => GetPoDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
    "Type": type,
    "PurType": purType,
    "Supplierid": supplierid,
    "ProjectId": projectId,
    "SiteId": siteId,
    "Supplier": supplier,
    "Project": project,
    "SiteName": siteName,
    "DeviceName": deviceName,
    "GetPODet": List<dynamic>.from(getPoDet!.map((x) => x.toJson())),
  };
}

class GetPoDet {
  GetPoDet({
    this.poDetId,
    this.materialId,
    this.materialName,
    this.unit,
    this.poQty,
    this.balQty,
    this.rate,
    this.inwQty,
    this.amdCheck,
    this.addQty,
    this.lessQty,
  });

  int? poDetId;
  int? materialId;
  String? materialName;
  String? unit;
  double? poQty;
  double? balQty;
  double? rate;
  double? inwQty;
  int? amdCheck;
  double? addQty;
  double? lessQty;

  factory GetPoDet.fromJson(Map<String, dynamic> json) => GetPoDet(
    poDetId: json["PODetId"],
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    poQty: json["POQty"],
    balQty: json["BalQty"],
    rate: json["Rate"].toDouble(),
    inwQty: json["InwQty"],
    amdCheck: json["AmdCheck"],
    addQty: json["AddQty"],
    lessQty: json["LessQty"],
  );

  Map<String, dynamic> toJson() => {
    "PODetId": poDetId,
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "POQty": poQty,
    "BalQty": balQty,
    "Rate": rate,
    "InwQty": inwQty,
    "AmdCheck": amdCheck,
    "AddQty": addQty,
    "LessQty": lessQty,
  };
}
