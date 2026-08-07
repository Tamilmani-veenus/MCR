class SiteLocationPayload {
  String? siteName;
  String? empId;
  String? punchDate;

  SiteLocationPayload({
    this.siteName,
    this.empId,
    this.punchDate,
  });


  Map<String, dynamic> toJson() => {
    "SiteName": siteName.toString(),
    "EmpId": empId.toString(),
    "Punch_date": punchDate.toString(),
  };
}
