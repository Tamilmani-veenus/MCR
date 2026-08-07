
import 'dart:convert';

List<ProjectDropdownListResponse> projectDropdownListFromJson(String str) => List<ProjectDropdownListResponse>.from(json.decode(str).map((x) => ProjectDropdownListResponse.fromJson(x)));

String projectDropdownListToJson(List<ProjectDropdownListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectDropdownListResponse {
  ProjectDropdownListResponse({
    this.projectId,
    this.project,
  });

  int? projectId;
  String? project;

  factory ProjectDropdownListResponse.fromJson(Map<String, dynamic> json) => ProjectDropdownListResponse(
    projectId: json["ProjectId"],
    project: json["Project"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "Project": project,
  };
}



List<HeadNameRes> headNameResFromJson(String str) => List<HeadNameRes>.from(json.decode(str).map((x) => HeadNameRes.fromJson(x)));

String headNameResToJson(List<HeadNameRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HeadNameRes {
  HeadNameRes({
    this.headitemId,
    this.headItem,
  });

  int? headitemId;
  String? headItem;

  factory HeadNameRes.fromJson(Map<String, dynamic> json) => HeadNameRes(
    headitemId: json["Headitem_id"],
    headItem: json["HeadItem"],
  );

  Map<String, dynamic> toJson() => {
    "Headitem_id": headitemId,
    "HeadItem": headItem,
  };
}
