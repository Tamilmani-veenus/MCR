// To parse this JSON data, do
//
//     final directbillEditApiResModel = directbillEditApiResModelFromJson(jsonString);

import 'dart:convert';

List<DirectbillEditApiResModel> directbillEditApiResModelFromJson(String str) => List<DirectbillEditApiResModel>.from(json.decode(str).map((x) => DirectbillEditApiResModel.fromJson(x)));

String directbillEditApiResModelToJson(List<DirectbillEditApiResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DirectbillEditApiResModel {
  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? projectName;
  String? siteName;
  String? subContName;
  String? entryType;
  String? fromDate;
  String? toDate;
  int? rndOff;
  int? billAmt;
  int? actAdvAmt;
  int? advAmt;
  int? netPayAmt;
  int? debitAmt;
  int? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  dynamic? userId;
  dynamic? entryMode;
  int? workOrderId;
  String? workOrderNo;
  List<BillEditDet>? billEditDet;
  List<BillEditAddless>? billEditAddless;

  DirectbillEditApiResModel({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.entryType,
    this.fromDate,
    this.toDate,
    this.rndOff,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.workOrderId,
    this.workOrderNo,
    this.billEditDet,
    this.billEditAddless,
  });

  factory DirectbillEditApiResModel.fromJson(Map<String, dynamic> json) => DirectbillEditApiResModel(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    entryType: json["EntryType"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    rndOff: json["RndOff"],
    billAmt: json["BillAmt"],
    actAdvAmt: json["ActAdvAmt"],
    advAmt: json["AdvAmt"],
    netPayAmt: json["NetPayAmt"],
    debitAmt: json["DebitAmt"],
    creditAmt: json["CreditAmt"],
    debitRemarks: json["DebitRemarks"],
    creditRemarks: json["CreditRemarks"],
    remarks: json["remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    workOrderId: json["WorkOrderId"],
    workOrderNo: json["WorkOrderNo"],
    billEditDet: List<BillEditDet>.from(json["BillEditDet"].map((x) => BillEditDet.fromJson(x))),
    billEditAddless: List<BillEditAddless>.from(json["BillEditAddless"].map((x) => BillEditAddless.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "EntryType": entryType,
    "FromDate": fromDate,
    "ToDate": toDate,
    "RndOff": rndOff,
    "BillAmt": billAmt,
    "ActAdvAmt": actAdvAmt,
    "AdvAmt": advAmt,
    "NetPayAmt": netPayAmt,
    "DebitAmt": debitAmt,
    "CreditAmt": creditAmt,
    "DebitRemarks": debitRemarks,
    "CreditRemarks": creditRemarks,
    "remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "WorkOrderId": workOrderId,
    "WorkOrderNo": workOrderNo,
    "BillEditDet": List<dynamic>.from(billEditDet!.map((x) => x.toJson())),
    "BillEditAddless": List<dynamic>.from(billEditAddless!.map((x) => x.toJson())),
  };
}

class BillEditAddless {
  int? addlessid;
  String? particular;
  String? addless;
  int? per;
  int? amount;

  BillEditAddless({
   this.addlessid,
   this.particular,
   this.addless,
   this.per,
   this.amount,
  });

  factory BillEditAddless.fromJson(Map<String, dynamic> json) => BillEditAddless(
    addlessid: json["addlessid"],
    particular: json["particular"],
    addless: json["addless"],
    per: json["per"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "addlessid": addlessid,
    "particular": particular,
    "addless": addless,
    "per": per,
    "amount": amount,
  };
}

class BillEditDet {
  String? itemDesc;
  String? unit;
  double? qty;
  double? rate;
  double? amount;

  BillEditDet({
   this.itemDesc,
   this.unit,
   this.qty,
   this.rate,
   this.amount,
  });

  factory BillEditDet.fromJson(Map<String, dynamic> json) => BillEditDet(
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
  };
}
