// import 'dart:convert';
//
//
// List<InwardPendingEditApiRes> inwardPendingEditApiResFromJson(String str) => List<InwardPendingEditApiRes>.from(json.decode(str).map((x) => InwardPendingEditApiRes.fromJson(x)));
//
// String inwardPendingEditApiResToJson(List<InwardPendingEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//
// class InwardPendingEditApiRes {
//   InwardPendingEditApiRes({
//     this.inwardId,
//     this.inwardNo,
//     this.inwardDate,
//     this.projectId,
//     this.siteId,
//     this.supplierId,
//     this.project,
//     this.siteName,
//     this.supplier,
//     this.dcNo,
//     this.dcDate,
//     this.invNo,
//     this.invDate,
//     this.preparedby,
//     this.preparedbyName,
//     this.remarks,
//     this.vehicleNo,
//     this.driverName,
//     this.id,
//     this.no,
//     this.type,
//     this.purType,
//     this.frieght,
//     this.loading,
//     this.roff,
//     this.netAmt,
//     this.inwardEditDet,
//   });
//
//   int? inwardId;
//   String? inwardNo;
//   String? inwardDate;
//   int? projectId;
//   int? siteId;
//   int? supplierId;
//   String? project;
//   String? siteName;
//   String? supplier;
//   String? dcNo;
//   String? dcDate;
//   String? invNo;
//   String? invDate;
//   int? preparedby;
//   String? preparedbyName;
//   String? remarks;
//   String? vehicleNo;
//   String? driverName;
//   int? id;
//   String? no;
//   String? type;
//   String? purType;
//   double? frieght;
//   double? loading;
//   double? roff;
//   double? netAmt;
//   List<InwardEditDet>? inwardEditDet;
//
//   factory InwardPendingEditApiRes.fromJson(Map<String, dynamic> json) => InwardPendingEditApiRes(
//     inwardId: json["InwardId"],
//     inwardNo: json["InwardNo"],
//     inwardDate: json["InwardDate"],
//     projectId: json["ProjectId"],
//     siteId: json["SiteId"],
//     supplierId: json["SupplierId"],
//     project: json["Project"],
//     siteName: json["SiteName"],
//     supplier: json["Supplier"],
//     dcNo: json["DCNo"],
//     dcDate: json["DCDate"],
//     invNo: json["InvNo"],
//     invDate: json["InvDate"],
//     preparedby: json["Preparedby"],
//     preparedbyName: json["PreparedbyName"],
//     remarks: json["Remarks"],
//     vehicleNo: json["VehicleNo"],
//     driverName: json["DriverName"],
//     id: json["Id"],
//     no: json["No"],
//     type: json["Type"],
//     purType: json["PurType"],
//     frieght: json["Frieght"],
//     loading: json["Loading"],
//     roff: json["Roff"],
//     netAmt: json["NetAmt"],
//     inwardEditDet: List<InwardEditDet>.from(json["InwardEditDet"].map((x) => InwardEditDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "InwardId": inwardId,
//     "InwardNo": inwardNo,
//     "InwardDate": inwardDate,
//     "ProjectId": projectId,
//     "SiteId": siteId,
//     "SupplierId": supplierId,
//     "Project": project,
//     "SiteName": siteName,
//     "Supplier": supplier,
//     "DCNo": dcNo,
//     "DCDate": dcDate,
//     "InvNo": invNo,
//     "InvDate": invDate,
//     "Preparedby": preparedby,
//     "PreparedbyName": preparedbyName,
//     "Remarks": remarks,
//     "VehicleNo": vehicleNo,
//     "DriverName": driverName,
//     "Id": id,
//     "No": no,
//     "Type": type,
//     "PurType": purType,
//     "Frieght": frieght,
//     "Loading": loading,
//     "Roff": roff,
//     "NetAmt": netAmt,
//     "InwardEditDet": List<dynamic>.from(inwardEditDet!.map((x) => x.toJson())),
//   };
// }
//
// class InwardEditDet {
//   InwardEditDet({
//     this.materialId,
//     this.materialName,
//     this.unit,
//     this.poQty,
//     this.rate,
//     this.balQty,
//     this.inwQty,
//     this.purOrdDetId,
//     this.reqOrdDetId,
//     this.amdCheck,
//     this.addQty,
//     this.lessQty,
//   });
//
//   int? materialId;
//   String? materialName;
//   String? unit;
//   double? poQty;
//   double? rate;
//   double? balQty;
//   double? inwQty;
//   int? purOrdDetId;
//   int? reqOrdDetId;
//   int? amdCheck;
//   double? addQty;
//   double? lessQty;
//
//   factory InwardEditDet.fromJson(Map<String, dynamic> json) => InwardEditDet(
//     materialId: json["MaterialId"],
//     materialName: json["MaterialName"],
//     unit: json["Unit"],
//     poQty: json["PoQty"],
//     rate: json["Rate"],
//     balQty: json["BalQty"],
//     inwQty: json["InwQty"],
//     purOrdDetId: json["PurOrdDetId"],
//     reqOrdDetId: json["ReqOrdDetId"],
//     amdCheck: json["AmdCheck"],
//     addQty: json["AddQty"],
//     lessQty: json["LessQty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialId": materialId,
//     "MaterialName": materialName,
//     "Unit": unit,
//     "PoQty": poQty,
//     "Rate": rate,
//     "BalQty": balQty,
//     "InwQty": inwQty,
//     "PurOrdDetId": purOrdDetId,
//     "ReqOrdDetId": reqOrdDetId,
//     "AmdCheck": amdCheck,
//     "AddQty": addQty,
//     "LessQty": lessQty,
//   };
// }


import 'dart:convert';


// List<InwardPendingEditApiRes> inwardPendingEditApiResFromJson(String str) => List<InwardPendingEditApiRes>.from(json.decode(str).map((x) => InwardPendingEditApiRes.fromJson(x)));
//
// String inwardPendingEditApiResToJson(List<InwardPendingEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//
// class InwardPendingEditApiRes {
//   InwardPendingEditApiRes({
//     this.inwardId,
//     this.gateEntryId,
//     this.inwardNo,
//     this.inwardDate,
//     this.projectId,
//     this.siteId,
//     this.supplierId,
//     this.project,
//     this.siteName,
//     this.supplier,
//     this.dcNo,
//     this.dcDate,
//     this.invNo,
//     this.invDate,
//     this.preparedby,
//     this.preparedbyName,
//     this.remarks,
//     this.vehicleNo,
//     this.driverName,
//     this.id,
//     this.no,
//     this.type,
//     this.purType,
//     this.frieght,
//     this.loading,
//     this.roff,
//     this.netAmt,
//     this.inwardEditDet,
//   });
//
//   int? inwardId;
//   int? gateEntryId;
//   String? inwardNo;
//   String? inwardDate;
//   int? projectId;
//   int? siteId;
//   int? supplierId;
//   String? project;
//   String? siteName;
//   String? supplier;
//   String? dcNo;
//   String? dcDate;
//   String? invNo;
//   String? invDate;
//   int? preparedby;
//   String? preparedbyName;
//   String? remarks;
//   String? vehicleNo;
//   String? driverName;
//   int? id;
//   String? no;
//   String? type;
//   String? purType;
//   double? frieght;
//   double? loading;
//   double? roff;
//   double? netAmt;
//   List<InwardEditDet>? inwardEditDet;
//
//   factory InwardPendingEditApiRes.fromJson(Map<String, dynamic> json) => InwardPendingEditApiRes(
//     inwardId: json["InwardId"],
//     gateEntryId: json["GateEntryId"],
//     inwardNo: json["InwardNo"],
//     inwardDate: json["InwardDate"],
//     projectId: json["ProjectId"],
//     siteId: json["SiteId"],
//     supplierId: json["SupplierId"],
//     project: json["Project"],
//     siteName: json["SiteName"],
//     supplier: json["Supplier"],
//     dcNo: json["DCNo"],
//     dcDate: json["DCDate"],
//     invNo: json["InvNo"],
//     invDate: json["InvDate"],
//     preparedby: json["Preparedby"],
//     preparedbyName: json["PreparedbyName"],
//     remarks: json["Remarks"],
//     vehicleNo: json["VehicleNo"],
//     driverName: json["DriverName"],
//     id: json["Id"],
//     no: json["No"],
//     type: json["Type"],
//     purType: json["PurType"],
//     frieght: json["Frieght"],
//     loading: json["Loading"],
//     roff: json["Roff"],
//     netAmt: json["NetAmt"],
//     inwardEditDet: List<InwardEditDet>.from(json["InwardEditDet"].map((x) => InwardEditDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "InwardId": inwardId,
//     "GateEntryId": gateEntryId,
//     "InwardNo": inwardNo,
//     "InwardDate": inwardDate,
//     "ProjectId": projectId,
//     "SiteId": siteId,
//     "SupplierId": supplierId,
//     "Project": project,
//     "SiteName": siteName,
//     "Supplier": supplier,
//     "DCNo": dcNo,
//     "DCDate": dcDate,
//     "InvNo": invNo,
//     "InvDate": invDate,
//     "Preparedby": preparedby,
//     "PreparedbyName": preparedbyName,
//     "Remarks": remarks,
//     "VehicleNo": vehicleNo,
//     "DriverName": driverName,
//     "Id": id,
//     "No": no,
//     "Type": type,
//     "PurType": purType,
//     "Frieght": frieght,
//     "Loading": loading,
//     "Roff": roff,
//     "NetAmt": netAmt,
//     "InwardEditDet": List<dynamic>.from(inwardEditDet!.map((x) => x.toJson())),
//   };
// }
//
// class InwardEditDet {
//   InwardEditDet({
//     this.materialId,
//     this.materialName,
//     this.unit,
//     this.poQty,
//     this.rate,
//     this.balQty,
//     this.inwQty,
//     this.purOrdDetId,
//     this.reqOrdDetId,
//     this.amdCheck,
//     this.addQty,
//     this.lessQty,
//   });
//
//   int? materialId;
//   String? materialName;
//   String? unit;
//   double? poQty;
//   double? rate;
//   double? balQty;
//   double? inwQty;
//   int? purOrdDetId;
//   int? reqOrdDetId;
//   int? amdCheck;
//   double? addQty;
//   double? lessQty;
//
//   factory InwardEditDet.fromJson(Map<String, dynamic> json) => InwardEditDet(
//     materialId: json["MaterialId"],
//     materialName: json["MaterialName"],
//     unit: json["Unit"],
//     poQty: json["PoQty"],
//     rate: json["Rate"],
//     balQty: json["BalQty"],
//     inwQty: json["InwQty"],
//     purOrdDetId: json["PurOrdDetId"],
//     reqOrdDetId: json["ReqOrdDetId"],
//     amdCheck: json["AmdCheck"],
//     addQty: json["AddQty"],
//     lessQty: json["LessQty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialId": materialId,
//     "MaterialName": materialName,
//     "Unit": unit,
//     "PoQty": poQty,
//     "Rate": rate,
//     "BalQty": balQty,
//     "InwQty": inwQty,
//     "PurOrdDetId": purOrdDetId,
//     "ReqOrdDetId": reqOrdDetId,
//     "AmdCheck": amdCheck,
//     "AddQty": addQty,
//     "LessQty": lessQty,
//   };
// }

// To parse this JSON data, do
//
//     final inwardPendingEditApiRes = inwardPendingEditApiResFromJson(jsonString);

import 'dart:convert';

InwardPendingEditApiRes inwardPendingEditApiResFromJson(String str) => InwardPendingEditApiRes.fromJson(json.decode(str));

String inwardPendingEditApiResToJson(InwardPendingEditApiRes data) => json.encode(data.toJson());

class InwardPendingEditApiRes {
  List<Result> result;
  String status;

  InwardPendingEditApiRes({
    required this.result,
    required this.status,
  });

  factory InwardPendingEditApiRes.fromJson(Map<String, dynamic> json) => InwardPendingEditApiRes(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "Status": status,
  };
}


class Result {
  Result({
    this.inwardId,
    this.inwardNo,
    this.inwardDate,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.project,
    this.siteName,
    this.supplier,
    this.dcNo,
    this.dcDate,
    this.invNo,
    this.invDate,
    this.preparedby,
    this.preparedbyName,
    this.remarks,
    this.vehicleNo,
    this.driverName,
    this.id,
    this.no,
    this.type,
    this.purType,
    this.frieght,
    this.loading,
    this.roff,
    this.netAmt,
    this.inwardEditDet,
  });

  int? inwardId;
  String? inwardNo;
  String? inwardDate;
  int? projectId;
  int? siteId;
  int? supplierId;
  String? project;
  String? siteName;
  String? supplier;
  String? dcNo;
  String? dcDate;
  String? invNo;
  String? invDate;
  int? preparedby;
  String? preparedbyName;
  String? remarks;
  String? vehicleNo;
  String? driverName;
  int? id;
  String? no;
  String? type;
  String? purType;
  double? frieght;
  double? loading;
  double? roff;
  double? netAmt;
  List<InwardEditDet>? inwardEditDet;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    inwardId: json["InwardId"],
    inwardNo: json["InwardNo"],
    inwardDate: json["InwardDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    supplierId: json["SupplierId"],
    project: json["Project"],
    siteName: json["SiteName"],
    supplier: json["Supplier"],
    dcNo: json["DCNo"],
    dcDate: json["DCDate"],
    invNo: json["InvNo"],
    invDate: json["InvDate"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    remarks: json["Remarks"],
    vehicleNo: json["VehicleNo"],
    driverName: json["DriverName"],
    id: json["Id"],
    no: json["No"],
    type: json["Type"],
    purType: json["PurType"],
    frieght: json["Frieght"],
    loading: json["Loading"],
    roff: json["Roff"],
    netAmt: json["NetAmt"],
    inwardEditDet: List<InwardEditDet>.from(json["InwardEditDet"].map((x) => InwardEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "InwardId": inwardId,
    "InwardNo": inwardNo,
    "InwardDate": inwardDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SupplierId": supplierId,
    "Project": project,
    "SiteName": siteName,
    "Supplier": supplier,
    "DCNo": dcNo,
    "DCDate": dcDate,
    "InvNo": invNo,
    "InvDate": invDate,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "Remarks": remarks,
    "VehicleNo": vehicleNo,
    "DriverName": driverName,
    "Id": id,
    "No": no,
    "Type": type,
    "PurType": purType,
    "Frieght": frieght,
    "Loading": loading,
    "Roff": roff,
    "NetAmt": netAmt,
    "InwardEditDet": List<dynamic>.from(inwardEditDet!.map((x) => x.toJson())),
  };
}

class InwardEditDet {
  InwardEditDet({
    this.materialId,
    this.materialName,
    this.unit,
    this.poQty,
    this.rate,
    this.balQty,
    this.inwQty,
    this.purOrdDetId,
    this.reqOrdDetId,
    this.amdCheck,
    this.addQty,
    this.lessQty,
  });

  int? materialId;
  String? materialName;
  String? unit;
  double? poQty;
  double? rate;
  double? balQty;
  double? inwQty;
  int? purOrdDetId;
  int? reqOrdDetId;
  int? amdCheck;
  double? addQty;
  double? lessQty;

  factory InwardEditDet.fromJson(Map<String, dynamic> json) => InwardEditDet(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    poQty: json["PoQty"],
    rate: json["Rate"],
    balQty: json["BalQty"],
    inwQty: json["InwQty"],
    purOrdDetId: json["PurOrdDetId"],
    reqOrdDetId: json["ReqOrdDetId"],
    amdCheck: json["AmdCheck"],
    addQty: json["AddQty"],
    lessQty: json["LessQty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "PoQty": poQty,
    "Rate": rate,
    "BalQty": balQty,
    "InwQty": inwQty,
    "PurOrdDetId": purOrdDetId,
    "ReqOrdDetId": reqOrdDetId,
    "AmdCheck": amdCheck,
    "AddQty": addQty,
    "LessQty": lessQty,
  };
}
