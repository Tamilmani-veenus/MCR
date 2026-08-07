// To parse this JSON data, do
//
//     final workOrdDirectEditModel = workOrdDirectEditModelFromJson(jsonString);

import 'dart:convert';

WorkOrdDirectEditModel workOrdDirectEditModelFromJson(String str) => WorkOrdDirectEditModel.fromJson(json.decode(str));

String workOrdDirectEditModelToJson(WorkOrdDirectEditModel data) => json.encode(data.toJson());

class WorkOrdDirectEditModel {
  bool? success;
  Result? result;
  String? message;

  WorkOrdDirectEditModel({
    this.success,
    this.result,
    this.message
  });

  factory WorkOrdDirectEditModel.fromJson(Map<String, dynamic> json) => WorkOrdDirectEditModel(
    success: json["Success"],
    result: Result.fromJson(json["Result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Result": result,
    "message": message
  };
}

class Result {
  List<Master>? master;
  List<EditDetail>? details;
  List<EditAddLess>? addLess;

  Result({
    this.master,
    this.details,
    this.addLess,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    master: List<Master>.from(json["Master"].map((x) => Master.fromJson(x))),
    details: List<EditDetail>.from(json["Details"].map((x) => EditDetail.fromJson(x))),
    addLess: List<EditAddLess>.from(json["AddLess"].map((x) => EditAddLess.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Master": List<dynamic>.from(master!.map((x) => x.toJson())),
    "Details": List<dynamic>.from(details!.map((x) => x.toJson())),
    "AddLess": List<dynamic>.from(addLess!.map((x) => x.toJson())),
  };
}

class EditAddLess {
  int? addLessId;
  String? particular;
  String? addLess;
  double? percentValue;
  double? amount;

  EditAddLess({
    this.addLessId,
    this.particular,
    this.addLess,
    this.percentValue,
    this.amount,
  });

  factory EditAddLess.fromJson(Map<String, dynamic> json) => EditAddLess(
    addLessId: json["AddLessId"],
    particular: json["Particular"],
    addLess: json["AddLess"],
    percentValue: json["Percentage"],
    amount: json["Amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "AddLessId": addLessId,
    "Particular": particular,
    "AddLess": addLess,
    "Percentage": percentValue,
    "Amount": amount,
  };
}

class EditDetail {
  String? itemDesc;
  String? unit;
  double? rate;
  double? qty;
  double? amount;

  EditDetail({
    this.itemDesc,
    this.unit,
    this.rate,
    this.qty,
    this.amount,
  });

  factory EditDetail.fromJson(Map<String, dynamic> json) => EditDetail(
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

class Master {
  int? workOrderId;
  String? workOrderNo;
  String? entryDate;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  int? subContId;
  String? subconName;
  double? workOrderAmt;
  double? roundOff;
  double? netAmount;
  String? workType;
  String? workTypeName;
  String? workStatus;
  String? workStatusName;
  String? remarks;
  String? termsCondition;
  String? activeStatus;
  String? activeStatusName;
  int? preparedBy;
  String? preparedByName;
  int? approvedBy;
  String? approvedByName;

  Master({
    this.workOrderId,
    this.workOrderNo,
    this.entryDate,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.subContId,
    this.subconName,
    this.workOrderAmt,
    this.roundOff,
    this.netAmount,
    this.workType,
    this.workTypeName,
    this.workStatus,
    this.workStatusName,
    this.remarks,
    this.termsCondition,
    this.activeStatus,
    this.activeStatusName,
    this.preparedBy,
    this.preparedByName,
    this.approvedBy,
    this.approvedByName,
  });

  factory Master.fromJson(Map<String, dynamic> json) => Master(
    workOrderId: json["Work_OrderId"],
    workOrderNo: json["WorkOrderNo"],
    entryDate: json["EntryDate"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    subContId: json["SubContId"],
    subconName: json["SubconName"],
    workOrderAmt: json["WorkOrderAmt"],
    roundOff: json["RoundOff"],
    netAmount: json["NetAmount"],
    workType: json["WorkType"],
    workTypeName: json["WorkTypeName"],
    workStatus: json["WorkStatus"],
    workStatusName: json["WorkStatusName"],
    remarks: json["Remarks"],
    termsCondition: json["TermsCondition"],
    activeStatus: json["ActiveStatus"],
    activeStatusName: json["ActiveStatusName"],
    preparedBy: json["PreparedBy"],
    preparedByName: json["PreparedByName"],
    approvedBy: json["ApprovedBy"],
    approvedByName: json["ApprovedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Work_OrderId": workOrderId,
    "WorkOrderNo": workOrderNo,
    "EntryDate": entryDate,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "SiteId": siteId,
    "SiteName": siteName,
    "SubContId": subContId,
    "SubconName": subconName,
    "WorkOrderAmt": workOrderAmt,
    "RoundOff": roundOff,
    "NetAmount": netAmount,
    "WorkType": workType,
    "WorkTypeName": workTypeName,
    "WorkStatus": workStatus,
    "WorkStatusName": workStatusName,
    "Remarks": remarks,
    "TermsCondition": termsCondition,
    "ActiveStatus": activeStatus,
    "ActiveStatusName": activeStatusName,
    "PreparedBy": preparedBy,
    "PreparedByName": preparedByName,
    "ApprovedBy": approvedBy,
    "ApprovedByName": approvedByName,
  };
}
