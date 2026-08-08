// To parse this JSON data, do
//
//     final workOrdDirectSaveModel = workOrdDirectSaveModelFromJson(jsonString);

import 'dart:convert';

WorkOrdDirectSaveModel workOrdDirectSaveModelFromJson(String str) => WorkOrdDirectSaveModel.fromJson(json.decode(str));

String workOrdDirectSaveModelToJson(WorkOrdDirectSaveModel data) => json.encode(data.toJson());

class WorkOrdDirectSaveModel {
  int? workorderId;
  String? workOrderNo;
  int? projectId;
  int? siteId;
  String? eDate;
  int? subContId;
  String? remarks;
  int? preparedBy;
  int? workOrderAmt;
  int? roundOff;
  int? netAmount;
  String? termsCondition;
  int? billWhaAmt;
  String? workStatus;
  String? activeStatus;
  String? userId;
  String? entryMode;
  String? deviceName;
  String? appstatus;
  String? verifystatus;
  String? verifiedby;
  String? approvedby;
  List<Detail>? details;
  List<AddLess>? addLess;

  WorkOrdDirectSaveModel({
    this.workorderId,
    this.workOrderNo,
    this.projectId,
    this.siteId,
    this.eDate,
    this.subContId,
    this.remarks,
    this.preparedBy,
    this.workOrderAmt,
    this.roundOff,
    this.netAmount,
    this.termsCondition,
    this.billWhaAmt,
    this.workStatus,
    this.activeStatus,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.appstatus,
    this.verifystatus,
    this.verifiedby,
    this.approvedby,
    this.details,
    this.addLess,
  });

  factory WorkOrdDirectSaveModel.fromJson(Map<String, dynamic> json) => WorkOrdDirectSaveModel(
    workorderId: json["WorkorderId"],
    workOrderNo: json["WorkOrderNo"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    eDate: json["EDate"],
    subContId: json["SubContId"],
    remarks: json["Remarks"],
    preparedBy: json["PreparedBy"],
    workOrderAmt: json["WorkOrderAmt"],
    roundOff: json["RoundOff"],
    netAmount: json["NetAmount"],
    termsCondition: json["TermsCondition"],
    billWhaAmt: json["BillWHAAmt"],
    workStatus: json["WorkStatus"],
    activeStatus: json["ActiveStatus"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    appstatus: json["Appstatus"],
    verifystatus: json["Verifystatus"],
    verifiedby: json["Verifiedby"],
    approvedby: json["Approvedby"],
    details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
    addLess: List<AddLess>.from(json["AddLess"].map((x) => AddLess.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkorderId": workorderId,
    "WorkOrderNo": workOrderNo,
    "ProjectId": projectId,
    "SiteId": siteId,
    "EDate": eDate,
    "SubContId": subContId,
    "Remarks": remarks,
    "PreparedBy": preparedBy,
    "WorkOrderAmt": workOrderAmt,
    "RoundOff": roundOff,
    "NetAmount": netAmount,
    "TermsCondition": termsCondition,
    "BillWHAAmt": billWhaAmt,
    "WorkStatus": workStatus,
    "ActiveStatus": activeStatus,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "Appstatus": appstatus,
    "Verifystatus": verifystatus,
    "Verifiedby": verifiedby,
    "Approvedby": approvedby,
    "Details": List<dynamic>.from(details!.map((x) => x.toJson())),
    "AddLess": List<dynamic>.from(addLess!.map((x) => x.toJson())),
  };
}

class AddLess {
  int? addLessId;
  String? percentage;
  String? amount;

  AddLess({
    this.addLessId,
    this.percentage,
    this.amount,
  });

  factory AddLess.fromJson(Map<String, dynamic> json) => AddLess(
    addLessId: json["AddLessId"],
    percentage: json["Percentage"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "AddLessId": addLessId,
    "Percentage": percentage,
    "Amount": amount,
  };
}

class Detail {
  String? itemDesc;
  String? unit;
  String? rate;
  String? qty;
  String? amount;

  Detail({
    this.itemDesc,
    this.unit,
    this.rate,
    this.qty,
    this.amount,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    rate: json["Rate"],
    qty: json["Qty"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Rate": rate,
    "Qty": qty,
    "Amount": amount,
  };
}
