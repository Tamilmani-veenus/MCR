import 'dart:convert';

GettingImage gettingImageFromJson(String str) => GettingImage.fromJson(json.decode(str));

String gettingImageToJson(GettingImage data) => json.encode(data.toJson());

class GettingImage {
  List<ImageView> imageView;

  GettingImage({
    required this.imageView,
  });

  factory GettingImage.fromJson(Map<String, dynamic> json) => GettingImage(
    imageView: List<ImageView>.from(json["ImageView"].map((x) => ImageView.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ImageView": List<dynamic>.from(imageView.map((x) => x.toJson())),
  };
}

class ImageView {
  int imageId;
  String imageUrl;

  ImageView({
    required this.imageId,
    required this.imageUrl,
  });

  factory ImageView.fromJson(Map<String, dynamic> json) => ImageView(
    imageId: json["ImageId"],
    imageUrl: json["ImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "ImageId": imageId,
    "ImageUrl": imageUrl,
  };
}
