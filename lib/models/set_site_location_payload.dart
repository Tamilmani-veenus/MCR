class SetSiteLocationPayload {
  String? projectid ;
  String? latitude;
  String? longitude;
  String? address;
  String? radius;
  String? entryMode;
  String? userId;
  String? deviceName;

  SetSiteLocationPayload({
    this.projectid ,
    this.latitude,
    this.longitude,
    this.address,
    this.radius,
    this.entryMode,
    this.userId,
    this.deviceName,
  });


  Map<String, dynamic> toJson() => {
    "Projectid": projectid .toString(),
    "Latitude": latitude.toString(),
    "Longitude": longitude.toString(),
    "Address": address.toString(),
    "Radius": radius.toString(),
    "EntryMode": entryMode.toString(),
    "UserId": userId.toString(),
    "DeviceName": deviceName.toString(),
  };
}
