 import 'dart:convert';
//
// SubcontEntryScreenSaveRequest subcontEntryScreenSaveFromJson(String str) => SubcontEntryScreenSaveRequest.fromJson(json.decode(str));
//
// String subcontEntryScreenSaveToJson(SubcontEntryScreenSaveRequest data) => json.encode(data.toJson());
//
// class SubcontEntryScreenSaveRequest {
//   SubcontEntryScreenSaveRequest({
//     this.attenId,
//     this.attenNo,
//     this.attenDate,
//     this.totNos,
//     this.totAmt,
//     this.projectId,
//     this.subContId,
//     this.workType,
//     this.shift,
//     this.remarks,
//     this.preparedby,
//     this.approvedby,
//     this.userId,
//     this.attendanceDet,
//   });
//   String? attenId;
//   String? attenNo;
//   String? attenDate;
//   String? totNos;
//   String? totAmt;
//   String? projectId;
//   String? subContId;
//   String? workType;
//   String? shift;
//   String? remarks;
//   String? preparedby;
//   String? approvedby;
//   String? userId;
//   List<AttendanceDet>? attendanceDet;
//
//   factory SubcontEntryScreenSaveRequest.fromJson(Map<String, dynamic> json) => SubcontEntryScreenSaveRequest(
//     attenId: json["attenId"],
//     attenNo: json["AttenNo"],
//     attenDate: json["AttenDate"],
//     totNos: json["TotNos"],
//     totAmt: json["TotAmt"],
//     projectId: json["ProjectId"],
//     subContId: json["SubContId"],
//     workType: json["WorkType"],
//     shift: json["Shift"],
//     remarks: json["Remarks"],
//     preparedby: json["Preparedby"],
//     approvedby: json["Approvedby"],
//     userId: json["UserId"],
//     attendanceDet: List<AttendanceDet>.from(json["AttendanceDet"].map((x) => AttendanceDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attenId": attenId,
//     "AttenNo": attenNo,
//     "AttenDate": attenDate,
//     "TotNos": totNos,
//     "TotAmt": totAmt,
//     "ProjectId": projectId,
//     "SubContId": subContId,
//     "WorkType": workType,
//     "Shift": shift,
//     "Remarks": remarks,
//     "Preparedby": preparedby,
//     "UserId": userId,
//     "AttendanceDet": List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
//   };
// }
//
// class AttendanceDet {
//   AttendanceDet({
//     this.siteId,
//     this.lbrCatId,
//     this.nos,
//     this.wages,
//     this.otNos,
//     this.otHrs,
//     this.totAmt,
//     this.extra,
//     this.detRemarks,
//   });
//
//   String? siteId;
//   String? lbrCatId;
//   String? nos;
//   String? wages;
//   String? otNos;
//   String? otHrs;
//   String? totAmt;
//   String? extra;
//   String? detRemarks;
//
//   factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
//     siteId: json["SiteId"],
//     lbrCatId: json["LbrCatId"],
//     nos: json["Nos"],
//     wages: json["Wages"],
//     otNos: json["OTNos"],
//     otHrs: json["OTHrs"],
//     totAmt: json["TotAmt"],
//     extra: json["Extra"],
//     detRemarks: json["DetRemarks"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SiteId": siteId,
//     "LbrCatId": lbrCatId,
//     "Nos": nos,
//     "Wages": wages,
//     "OTNos": otNos,
//     "OTHrs": otHrs,
//     "TotAmt": totAmt,
//     "Extra": extra,
//     "DetRemarks": detRemarks,
//   };
// }


SubcontEntryscreenSaveResponse subcontEntryscreenSaveResponseFromJson(String str) => SubcontEntryscreenSaveResponse.fromJson(json.decode(str));

String subcontEntryscreenSaveResponseToJson(SubcontEntryscreenSaveResponse data) => json.encode(data.toJson());

class SubcontEntryscreenSaveResponse {
  SubcontEntryscreenSaveResponse({
    this.RetString,
  });

  String? RetString;

  factory SubcontEntryscreenSaveResponse.fromJson(Map<String, dynamic> json) => SubcontEntryscreenSaveResponse(
    RetString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": RetString,
  };
}



// SubcontEntryScreenSaveRequest subcontEntryScreenSaveRequestFromJson(String str) => SubcontEntryScreenSaveRequest.fromJson(json.decode(str));
//
// String subcontEntryScreenSaveRequestToJson(SubcontEntryScreenSaveRequest data) => json.encode(data.toJson());
//
//
// class SubcontEntryScreenSaveRequest {
//   SubcontEntryScreenSaveRequest({
//     this.attenId,
//     this.attenNo,
//     this.attenDate,
//     this.totNos,
//     this.totAmt,
//     this.projectId,
//     this.subContId,
//     this.siteId,
//     this.workType,
//     this.shift,
//     this.remarks,
//     this.preparedby,
//     this.approvedby,
//     this.userId,
//     this.attendanceDet,
//     this.EmpId,
//     this.EntryMode,
//     this.DeviceName,
//   });
//
//   String? attenId;
//   String? attenNo;
//   String? attenDate;
//   String? totNos;
//   String? totAmt;
//   String? projectId;
//   String? subContId;
//   String? siteId;
//   String? workType;
//   String? shift;
//   String? remarks;
//   String? preparedby;
//   String? approvedby;
//   String? userId;
//   String? EmpId;
//   String? EntryMode;
//   String? DeviceName;
//
//
//
//   List<AttendanceDet>? attendanceDet;
//
//   factory SubcontEntryScreenSaveRequest.fromJson(Map<String, dynamic> json) => SubcontEntryScreenSaveRequest(
//     attenId: json["attenId"],
//     attenNo: json["AttenNo"],
//     attenDate:json["AttenDate"],
//     totNos: json["TotNos"],
//     totAmt: json["TotAmt"],
//     projectId: json["ProjectId"],
//     subContId: json["SubContId"],
//     siteId: json["SiteId"],
//     workType: json["WorkType"],
//     shift: json["Shift"],
//     remarks: json["Remarks"],
//     preparedby: json["Preparedby"],
//     approvedby: json["Approvedby"],
//     userId: json["UserId"],
//     EmpId: json["EmpId"],
//     EntryMode: json["EntryMode"],
//     DeviceName: json["DeviceName"],
//     attendanceDet: List<AttendanceDet>.from(json["AttendanceDet"].map((x) => AttendanceDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attenId": attenId,
//     "AttenNo": attenNo,
//     "AttenDate": attenDate,
//     "TotNos": totNos,
//     "TotAmt": totAmt,
//     "ProjectId": projectId,
//     "SubContId": subContId,
//     "SiteId": siteId,
//     "WorkType": workType,
//     "Shift": shift,
//     "Remarks": remarks,
//     "Preparedby": preparedby,
//     "Approvedby": approvedby,
//     "UserId": userId,
//     "EmpId": EmpId,
//     "EntryMode": EntryMode,
//     "DeviceName": DeviceName,
//     "AttendanceDet": List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
//   };
// }
//
// class AttendanceDet {
//   AttendanceDet({
//     this.siteId,
//     this.lbrCatId,
//     this.nos,
//     this.wages,
//     this.extra,
//     this.detRemarks,
//    this. MOROTHrs,
//    this. MOROTAmt,
//    this. EVEOTHrs,
//    this. ExtraAmt,
//    this. EVEOTAmt,
//    this. TotAmt,
//    this. Extra,
//
//   });
//
//   String? siteId;
//   String? lbrCatId;
//   String? nos;
//   String? wages;
//   String? MOROTHrs;
//   String? MOROTAmt;
//   String? EVEOTHrs;
//   String? ExtraAmt;
//   String? EVEOTAmt;
//   String? TotAmt;
//   String? Extra;
//   String? extra;
//   String? detRemarks;
//
//   factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
//     siteId: json["SiteId"],
//     lbrCatId: json["LbrCatId"],
//     nos: json["Nos"],
//     wages: json["Wages"],
//     extra: json["Extra"],
//     detRemarks: json["DetRemarks"],
//     MOROTHrs: json["MOROTHrs"],
//     MOROTAmt: json["MOROTAmt"],
//     EVEOTHrs: json["EVEOTHrs"],
//     ExtraAmt: json["ExtraAmt"],
//     EVEOTAmt: json["EVEOTAmt"],
//     TotAmt: json["TotAmt"],
//     Extra: json["Extra"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SiteId": siteId,
//     "LbrCatId": lbrCatId,
//     "Nos": nos,
//     "Wages": wages,
//     "Extra": extra,
//     "DetRemarks": detRemarks,
//     "MOROTHrs": MOROTHrs,
//     "MOROTAmt": MOROTAmt,
//     "EVEOTHrs": EVEOTHrs,
//     "ExtraAmt": ExtraAmt,
//     "EVEOTAmt": EVEOTAmt,
//     "TotAmt": TotAmt,
//     "Extra": Extra,
//   };
// }


 SubcontEntryScreenSaveRequest subcontEntryScreenSaveRequestFromJson(String str) => SubcontEntryScreenSaveRequest.fromJson(json.decode(str));

 String subcontEntryScreenSaveRequestToJson(SubcontEntryScreenSaveRequest data) => json.encode(data.toJson());


 class SubcontEntryScreenSaveRequest {
   SubcontEntryScreenSaveRequest({
     this.attenId,
     this.attenNo,
     this.attenDate,
     this.totNos,
     this.totAmt,
     this.projectId,
     this.subContId,
     this.siteId,
     this.workType,
     this.shift,
     this.remarks,
     this.preparedby,
     this.approvedby,
     this.userId,
     this.attendanceDet,
     this.EmpId,
     this.EntryMode,
     this.DeviceName,
   });

   String? attenId;
   String? attenNo;
   String? attenDate;
   String? totNos;
   String? totAmt;
   String? projectId;
   String? subContId;
   String? siteId;
   String? workType;
   String? shift;
   String? remarks;
   String? preparedby;
   String? approvedby;
   String? userId;
   String? EmpId;
   String? EntryMode;
   String? DeviceName;



   List<AttendanceDet>? attendanceDet;

   factory SubcontEntryScreenSaveRequest.fromJson(Map<String, dynamic> json) => SubcontEntryScreenSaveRequest(
     attenId: json["attenId"],
     attenNo: json["AttenNo"],
     attenDate:json["AttenDate"],
     totNos: json["TotNos"],
     totAmt: json["TotAmt"],
     projectId: json["ProjectId"],
     subContId: json["SubContId"],
     siteId: json["SiteId"],
     workType: json["WorkType"],
     shift: json["Shift"],
     remarks: json["Remarks"],
     preparedby: json["Preparedby"],
     approvedby: json["Approvedby"],
     userId: json["UserId"],
     EmpId: json["EmpId"],
     EntryMode: json["EntryMode"],
     DeviceName: json["DeviceName"],
     attendanceDet: List<AttendanceDet>.from(json["AttendanceDet"].map((x) => AttendanceDet.fromJson(x))),
   );

   Map<String, dynamic> toJson() => {
     "attenId": attenId,
     "AttenNo": attenNo,
     "AttenDate": attenDate,
     "TotNos": totNos,
     "TotAmt": totAmt,
     "ProjectId": projectId,
     "SubContId": subContId,
     "SiteId": siteId,
     "WorkType": workType,
     "Shift": shift,
     "Remarks": remarks,
     "Preparedby": preparedby,
     "Approvedby": approvedby,
     "UserId": userId,
     "EmpId": EmpId,
     "EntryMode": EntryMode,
     "DeviceName": DeviceName,
     "AttendanceDet": List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
   };
 }

 class AttendanceDet {
   AttendanceDet({
     this.siteId,
     this.lbrCatId,
     this.nos,
     this.wages,
     this.extra,
     this.detRemarks,
     this. MOROTHrs,
     this. MOROTAmt,
     this. EVEOTHrs,
     this. ExtraAmt,
     this. EVEOTAmt,
     this. TotAmt,
     this. Extra,

   });

   String? siteId;
   String? lbrCatId;
   String? nos;
   String? wages;
   String? MOROTHrs;
   String? MOROTAmt;
   String? EVEOTHrs;
   String? ExtraAmt;
   String? EVEOTAmt;
   String? TotAmt;
   String? Extra;
   String? extra;
   String? detRemarks;

   factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
     siteId: json["SiteId"],
     lbrCatId: json["LbrCatId"],
     nos: json["Nos"],
     wages: json["Wages"],
     extra: json["Extra"],
     detRemarks: json["DetRemarks"],
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
     "Extra": extra,
     "DetRemarks": detRemarks,
     "MOROTHrs": MOROTHrs,
     "MOROTAmt": MOROTAmt,
     "EVEOTHrs": EVEOTHrs,
     "ExtraAmt": ExtraAmt,
     "EVEOTAmt": EVEOTAmt,
     "TotAmt": TotAmt,
     "Extra": Extra,
   };
 }

