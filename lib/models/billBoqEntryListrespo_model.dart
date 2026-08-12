// To parse this JSON data, do
//
//     final billBoqEntryModel = billBoqEntryModelFromJson(jsonString);

import 'dart:convert';

List<BillBoqEntryModel> billBoqEntryModelFromJson(String str) => List<BillBoqEntryModel>.from(json.decode(str).map((x) => BillBoqEntryModel.fromJson(x)));

String billBoqEntryModelToJson(List<BillBoqEntryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillBoqEntryModel {
  int? workId;
  String? workNo;
  String? workDate;
  String? fdate;
  String? tdate;
  String? project;
  String? siteName;
  String? subconName;
  int? projectId;
  int? subContId;
  String? fworkDate;
  String? tworkDate;
  int? workOrderid;
  String? preparedByName;
  String? partRate;
  double? netPayAmt;
  String? verifyStatus;
  String? appStatus;
  String? status;

  BillBoqEntryModel({
    this.workId,
    this.workNo,
    this.workDate,
    this.fdate,
    this.tdate,
    this.project,
    this.siteName,
    this.subconName,
    this.projectId,
    this.subContId,
    this.fworkDate,
    this.tworkDate,
    this.workOrderid,
    this.preparedByName,
    this.partRate,
    this.netPayAmt,
    this.verifyStatus,
    this.appStatus,
    this.status,
  });

  factory BillBoqEntryModel.fromJson(Map<String, dynamic> json) => BillBoqEntryModel(
    workId: json["Work_Id"],
    workNo: json["Work_No"],
    workDate: json["Work_Date"],
    fdate: json["fdate"],
    tdate: json["tdate"],
    project: json["Project"],
    siteName: json["SiteName"],
    subconName: json["Subcon_name"],
    projectId: json["ProjectId"],
    subContId: json["SubContId"],
    fworkDate: json["fwork_date"],
    tworkDate: json["twork_date"],
    workOrderid: json["work_orderid"],
    preparedByName: json["PreparedByName"],
    partRate: json["Part_rate"],
    netPayAmt: json["net_pay_amt"],
    verifyStatus: json["VerifyStatus"],
    appStatus: json["AppStatus"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Work_Id": workId,
    "Work_No": workNo,
    "Work_Date": workDate,
    "fdate": fdate,
    "tdate": tdate,
    "Project": project,
    "SiteName": siteName,
    "Subcon_name": subconName,
    "ProjectId": projectId,
    "SubContId": subContId,
    "fwork_date": fworkDate,
    "twork_date": tworkDate,
    "work_orderid": workOrderid,
    "PreparedByName": preparedByName,
    "Part_rate": partRate,
    "net_pay_amt": netPayAmt,
    "VerifyStatus": verifyStatus,
    "AppStatus": appStatus,
    "Status": status,
  };
}
