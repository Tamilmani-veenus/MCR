// To parse this JSON data, do
//
//     final billDirectGenSaveApiReq = billDirectGenSaveApiReqFromJson(jsonString);

import 'dart:convert';

BillDirectGenSaveApiReq billDirectGenSaveApiReqFromJson(String str) => BillDirectGenSaveApiReq.fromJson(json.decode(str));

String billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq data) => json.encode(data.toJson());

class BillDirectGenSaveApiReq {
  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  double? rndOff;
  String? appstatus;
  int? approvedby;
  double? balAmt;
  String? remarks;
  int? preparedby;
  String? fromDate;
  String? toDate;
  String? entryType;
  int? workOrderid;
  double? billAmt;
  double? actAdvAmt;
  double? advAmt;
  double? netPayAmt;
  double? debitAmt;
  double? creditAmt;
  double? billWhaAmount;
  String? debitRemarks;
  String? creditRemarks;
  String? billNo;
  String? verifySatus;
  int? verifyby;
  double? materialdebitAmt;
  String? materiadebitremarks;
  String? paymentDate;
  String? entryMode;
  int? userId;
  String? deviceName;
  List<BillDet>? billDet;
  List<BillAddless>? billAddless;

  BillDirectGenSaveApiReq({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.rndOff,
    this.appstatus,
    this.approvedby,
    this.balAmt,
    this.billWhaAmount,
    this.remarks,
    this.preparedby,
    this.fromDate,
    this.toDate,
    this.entryType,
    this.workOrderid,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.billNo,
    this.verifySatus,
    this.verifyby,
    this.materialdebitAmt,
    this.materiadebitremarks,
    this.paymentDate,
    this.entryMode,
    this.userId,
    this.deviceName,
    this.billDet,
    this.billAddless,
  });

  factory BillDirectGenSaveApiReq.fromJson(Map<String, dynamic> json) => BillDirectGenSaveApiReq(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    rndOff: json["RndOff"],
    appstatus: json["Appstatus"],
    approvedby: json["Approvedby"],
    balAmt: json["BalAmt"],
    billWhaAmount: json["BillWhaAmount"],
    remarks: json["remarks"],
    preparedby: json["Preparedby"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    entryType: json["EntryType"],
    workOrderid: json["WorkOrderid"],
    billAmt: json["BillAmt"],
    actAdvAmt: json["ActAdvAmt"],
    advAmt: json["AdvAmt"],
    netPayAmt: json["NetPayAmt"],
    debitAmt: json["DebitAmt"],
    creditAmt: json["CreditAmt"],
    debitRemarks: json["DebitRemarks"],
    creditRemarks: json["CreditRemarks"],
    billNo: json["BillNo"],
    verifySatus: json["verifySatus"],
    verifyby: json["Verifyby"],
    materialdebitAmt: json["MaterialdebitAmt"],
    materiadebitremarks: json["Materiadebitremarks"],
    paymentDate: json["PaymentDate"],
    entryMode: json["EntryMode"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    billDet: List<BillDet>.from(json["BillDet"].map((x) => BillDet.fromJson(x))),
    billAddless: List<BillAddless>.from(json["BillAddless"].map((x) => BillAddless.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkNo": workNo,
    "WorkId": workId,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "RndOff": rndOff,
    "BillWhaAmount": billWhaAmount,
    "Appstatus": appstatus,
    "Approvedby": approvedby,
    "BalAmt": balAmt,
    "remarks": remarks,
    "Preparedby": preparedby,
    "FromDate": fromDate,
    "ToDate": toDate,
    "EntryType": entryType,
    "WorkOrderid": workOrderid,
    "BillAmt": billAmt,
    "ActAdvAmt": actAdvAmt,
    "AdvAmt": advAmt,
    "NetPayAmt": netPayAmt,
    "DebitAmt": debitAmt,
    "CreditAmt": creditAmt,
    "DebitRemarks": debitRemarks,
    "CreditRemarks": creditRemarks,
    "BillNo": billNo,
    "verifySatus": verifySatus,
    "Verifyby": verifyby,
    "MaterialdebitAmt": materialdebitAmt,
    "Materiadebitremarks": materiadebitremarks,
    "PaymentDate": paymentDate,
    "EntryMode": entryMode,
    "UserId": userId,
    "DeviceName": deviceName,
    "BillDet": List<dynamic>.from(billDet!.map((x) => x.toJson())),
    "BillAddless": List<dynamic>.from(billAddless!.map((x) => x.toJson())),
  };
}

class BillAddless {
  int? alId;
  double? percent;
  double? amount;

  BillAddless({
   this.alId,
   this.percent,
   this.amount,
  });

  factory BillAddless.fromJson(Map<String, dynamic> json) => BillAddless(
    alId: json["ALId"],
    percent: json["Percent"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "ALId": alId,
    "Percent": percent,
    "Amount": amount,
  };
}

class BillDet {
  String? unit;
  double? rate;
  double? amt;
  double? actualQty;
  int? workorderdetid;
  String? wtype;
  String? itemDes;

  BillDet({
  this.unit,
  this.rate,
  this.amt,
  this.actualQty,
  this.workorderdetid,
  this.wtype,
  this.itemDes,
  });

  factory BillDet.fromJson(Map<String, dynamic> json) => BillDet(
    unit: json["Unit"],
    rate: json["Rate"],
    amt: json["Amt"],
    actualQty: json["ActualQty"],
    workorderdetid: json["Workorderdetid"],
    wtype: json["Wtype"],
    itemDes: json["ItemDes"],
  );

  Map<String, dynamic> toJson() => {
    "Unit": unit,
    "Rate": rate,
    "Amt": amt,
    "ActualQty": actualQty,
    "Workorderdetid": workorderdetid,
    "Wtype": wtype,
    "ItemDes": itemDes,
  };
}
