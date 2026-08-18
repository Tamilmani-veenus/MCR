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
  String? materialDebitRemarks;
  double? rndOff;
  double? materialDebit;
  double? billAmt;
  double? actAdvAmt;
  double? advAmt;
  double? netPayAmt;
  double? debitAmt;
  double? creditAmt;
  double? dndAmt;
  double? totAmt;
  double? balAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  String? billNo;
  String? paymentDate;
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
    this.materialDebitRemarks,
    this.projectId,
    this.billNo,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.materialDebit,
    this.entryType,
    this.fromDate,
    this.toDate,
    this.rndOff,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.paymentDate,
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
    materialDebitRemarks: json["MaterialDebitRemarks"],
    billNo: json["BillNo"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    materialDebit: json["MaterialDebit"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    paymentDate: json["PaymentDate"],
    entryType: json["EntryType"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    rndOff: json["RndOff"],
    billAmt: json["BillAmt"] ?? json["BillWhaAmt"],
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
    "MaterialDebitRemarks": materialDebitRemarks,
    "ProjectId": projectId,
    "SiteId": siteId,
    "BillNo": billNo,
    "PaymentDate": paymentDate,
    "MaterialDebit": materialDebit,
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
 double? per;
 double? amount;

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
  int? headItemId;
  int? subItemId;
  int? level3ItemId;
  int? workorderDetId;
  String? boqCode;
  String? itemCode;
  double? actualQty;
  double? curBillQty;
  double? balBillQty;
  double? totalQty;
  double? flat;
  double? WOBalQty;
  int? qtyIsClosed;
  int? wHeadItemId;
  int? wSubItemId;
  String? status;


  BillEditDet({
   this.itemDesc,
   this.headItemId,
   this.subItemId,
   this.unit,
   this.qty,
   this.rate,
   this.amount,
   this.level3ItemId,
   this.workorderDetId,
   this.boqCode,
   this.itemCode,
   this.actualQty,
   this.curBillQty,
   this.balBillQty,
   this.totalQty,
   this.WOBalQty,
   this.flat,
   this.qtyIsClosed,
   this.wHeadItemId,
   this.wSubItemId,
   this.status,
  });

  factory BillEditDet.fromJson(Map<String, dynamic> json) => BillEditDet(
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    headItemId: json["HeadItemId"],
    subItemId: json["SubItemId"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    level3ItemId: json["Level3ItemId"],
    boqCode: json["BoqCode"],
    itemCode: json["ItemCode"],
    actualQty: json["ActualQty"],
    curBillQty: json["CurBillQty"],
    balBillQty: json["BalBillQty"],
    totalQty: json["TotalQty"],
    flat: json["Flat"],
    qtyIsClosed: json["QtyIsClosed"],
    wHeadItemId: json["WHeadItemId"],
    wSubItemId: json["WSubItemId"],
    WOBalQty: json["WOBalQty"],
    status: json["Status"],
    workorderDetId: json["WorkorderDetId"],
  );

  Map<String, dynamic> toJson() => {
    "ItemDesc": itemDesc,
    "HeadItemId": headItemId,
    "SubItemId": subItemId,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "Level3ItemId": level3ItemId,
    "BoqCode": boqCode,
    "ItemCode": itemCode,
    "ActualQty": actualQty,
    "CurBillQty": curBillQty,
    "BalBillQty": balBillQty,
    "TotalQty": totalQty,
    "Flat": flat,
    "QtyIsClosed": qtyIsClosed,
    "WHeadItemId": wHeadItemId,
    "WSubItemId": wSubItemId,
    "WOBalQty": WOBalQty,
    "WorkorderDetId": workorderDetId,
  };
}
