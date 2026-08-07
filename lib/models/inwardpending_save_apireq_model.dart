import 'dart:convert';
import 'dart:io';
InwardPendingSaveReq inwardPendingSaveReqFromJson(String str) => InwardPendingSaveReq.fromJson(json.decode(str));

String inwardPendingSaveReqToJson(InwardPendingSaveReq data) => json.encode(data.toJson());

class InwardPendingSaveReq {
  InwardPendingSaveReq({
    this.inwardId,
    this.inwardNo,
    this.inwardDate,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.dcNo,
    this.dcDate,
    this.remarks,
    this.preparedby,
    this.vehicleNo,
    this.driverName,
    this.invNo,
    this.invDate,
    this.id,
    this.no,
    this.type,
    this.purType,
    this.frieght,
    this.loading,
    this.roff,
    this.netAmt,
    this.image,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.ChkAmdSave,
    this.inwardDet,
    this.files,
    // this.imageDet,
  });

  String? inwardId;
  String? inwardNo;
  String? inwardDate;
  String? projectId;
  String? siteId;
  String? supplierId;
  String? dcNo;
  String? dcDate;
  String? remarks;
  String? preparedby;
  String? vehicleNo;
  String? driverName;
  String? invNo;
  String? invDate;
  String? id;
  String? no;
  String? type;
  String? purType;
  String? frieght;
  String? loading;
  String? roff;
  String? netAmt;
  String? image;
  String? userId;
  String? deviceName;
  String? entryMode;
  String? ChkAmdSave;
  List<InwardDet>? inwardDet;
  List<File>? files;
  // List<ImageDet>? imageDet;

  factory InwardPendingSaveReq.fromJson(Map<String, dynamic> json) => InwardPendingSaveReq(
    inwardId: json["InwardId"],
    inwardNo: json["InwardNo"],
    inwardDate: json["InwardDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    supplierId: json["SupplierId"],
    dcNo: json["DCNo"],
    dcDate: json["DCDate"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    vehicleNo: json["VehicleNo"],
    driverName: json["DriverName"],
    invNo: json["InvNo"],
    invDate: json["InvDate"],
    id: json["Id"],
    no: json["No"],
    type: json["Type"],
    purType: json["PurType"],
    frieght: json["Frieght"],
    loading: json["Loading"],
    roff: json["Roff"],
    netAmt: json["NetAmt"],
    image: json["image"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    ChkAmdSave: json["ChkAmdSave"],
    entryMode: json["EntryMode"],
    inwardDet: List<InwardDet>.from(json["InwardDet"].map((x) => InwardDet.fromJson(x))),
    // imageDet: List<ImageDet>.from(json["ImageDet"].map((x) => ImageDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "InwardId": inwardId,
    "InwardNo": inwardNo,
    "InwardDate": inwardDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SupplierId": supplierId,
    "DCNo": dcNo,
    "DCDate": dcDate,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "VehicleNo": vehicleNo,
    "DriverName": driverName,
    "InvNo": invNo,
    "InvDate": invDate,
    "Id": id,
    "No": no,
    "Type": type,
    "PurType": purType,
    "Frieght": frieght,
    "Loading": loading,
    "Roff": roff,
    "NetAmt": netAmt,
    "image": image,
    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "ChkAmdSave": ChkAmdSave,
    "InwardDet": List<dynamic>.from(inwardDet!.map((x) => x.toJson())),
    // "ImageDet": List<dynamic>.from(imageDet!.map((x) => x.toJson())),
  };
}

class ImageDet {
  ImageDet({
    this.imageid,
    this.photoPath,
    this.data,
  });

  String? imageid;
  String? photoPath;
  String? data;

  factory ImageDet.fromJson(Map<String, dynamic> json) => ImageDet(
    imageid: json["imageid"],
    photoPath: json["Photo_Path"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "imageid": imageid,
    "Photo_Path": photoPath,
    "data": data,
  };
}

class InwardDet {
  InwardDet({
    this.materialId,
    this.qty,
    this.balQty,
    this.rate,
    this.amount,
    this.purOrdDetId,
    this.reqOrdDetId,
    this.amdCheck,
    this.addQty,
    this.lessQty,
  });

  String? materialId;
  String? qty;
  String? balQty;
  String? rate;
  double? amount;
  String? purOrdDetId;
  String? reqOrdDetId;
  String? amdCheck;
  String? addQty;
  String? lessQty;

  factory InwardDet.fromJson(Map<String, dynamic> json) => InwardDet(
    materialId: json["MaterialId"],
    qty: json["Qty"],
    balQty: json["BalQty"],
    rate: json["Rate"],
    amount: json["Amount"],
    purOrdDetId: json["PurOrdDetId"],
    reqOrdDetId: json["ReqOrdDetId"],
    amdCheck: json["AMDCheck"],
    addQty: json["AddQty"],
    lessQty: json["LessQty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Qty": qty,
    "BalQty": balQty,
    "Rate": rate,
    "Amount": amount,
    "PurOrdDetId": purOrdDetId,
    "ReqOrdDetId": reqOrdDetId,
    "AMDCheck": amdCheck,
    "AddQty": addQty,
    "LessQty": lessQty,
  };
}
