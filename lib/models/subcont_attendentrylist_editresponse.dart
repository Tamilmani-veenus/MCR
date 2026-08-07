import 'dart:convert';

List<SubContAttendEntryListEditRes> subContAttendEntryListEditResFromJson(String str) => List<SubContAttendEntryListEditRes>.from(json.decode(str).map((x) => SubContAttendEntryListEditRes.fromJson(x)));

String subContAttendEntryListEditResToJson(List<SubContAttendEntryListEditRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubContAttendEntryListEditRes {
  SubContAttendEntryListEditRes({
    this.attenId,
    this.attenNo,
    this.attenDate,
    this.totNos,
    this.totAmt,
    this.projectId,
    this.subContId,
    this.workType,
    this.shift,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.projectName,
    this.subContName,
    this.userId,
    this.entryMode,
    this.attendanceDet,
  });

  int? attenId;
  String? attenNo;
  String? attenDate;
  double? totNos;
  double? totAmt;
  int? projectId;
  int? subContId;
  String? workType;
  String? shift;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  String? projectName;
  String? subContName;
  int? userId;
  String? entryMode;
  List<AttendanceDet>? attendanceDet;

  factory SubContAttendEntryListEditRes.fromJson(Map<String, dynamic> json) => SubContAttendEntryListEditRes(
    attenId: json["AttenId"],
    attenNo: json["AttenNo"],
    attenDate: json["AttenDate"],
    totNos: json["TotNos"],
    totAmt: json["TotAmt"],
    projectId: json["ProjectId"],
    subContId: json["SubContId"],
    workType: json["WorkType"],
    shift: json["Shift"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    projectName: json["ProjectName"],
    subContName: json["SubContName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    attendanceDet: List<AttendanceDet>.from(json["AttendanceDet"].map((x) => AttendanceDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AttenId": attenId,
    "AttenNo": attenNo,
    "AttenDate":attenDate,
    "TotNos": totNos,
    "TotAmt": totAmt,
    "ProjectId": projectId,
    "SubContId": subContId,
    "WorkType": workType,
    "Shift": shift,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "ProjectName": projectName,
    "SubContName": subContName,
    "UserId": userId,
    "EntryMode": entryMode,
    "AttendanceDet": List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
  };
}

class AttendanceDet {
  AttendanceDet({
    this.siteId,
    this.lbrCatId,
    this.nos,
    this.wages,
    this.detRemarks,
    this.siteName,
    this.categoryName,
    this.MOROTHrs,
    this.MOROTAmt,
    this.EVEOTHrs,
    this.ExtraAmt,
    this.EVEOTAmt,
    this.TotAmt,
    this.Extra,
  });

  int? siteId;
  int? lbrCatId;
  double? nos;
  double? wages;
  double? MOROTHrs;
  double? MOROTAmt;
  double? EVEOTHrs;
  double? ExtraAmt;
  double? EVEOTAmt;
  double? TotAmt;
  double? Extra;
  String? detRemarks;
  String? siteName;
  String? categoryName;

  factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
    siteId: json["SiteId"],
    lbrCatId: json["LbrCatId"],
    nos: json["Nos"],
    wages: json["Wages"],
    detRemarks: json["DetRemarks"],
    siteName: json["SiteName"],
    categoryName: json["CategoryName"],
    MOROTHrs: json["MOROTHrs"],
    MOROTAmt: json["MOROTAmt"],
    EVEOTHrs: json["EVEOTHrs"],
    ExtraAmt: json["ExtraAmt"],
    EVEOTAmt: json["EVEOTAmt"],
    TotAmt: json["TotAmt"],
    Extra: json["Extra"],
  );

  Map<String, dynamic> toJson() => {
    "SiteId": siteId,
    "LbrCatId": lbrCatId,
    "Nos": nos,
    "Wages": wages,
    "DetRemarks": detRemarks,
    "SiteName": siteName,
    "CategoryName": categoryName,
    "MOROTHrs": MOROTHrs,
    "MOROTAmt": MOROTAmt,
    "EVEOTHrs": EVEOTHrs,
    "ExtraAmt": ExtraAmt,
    "EVEOTAmt": EVEOTAmt,
    "TotAmt": TotAmt,
    "Extra": Extra,
  };
}
