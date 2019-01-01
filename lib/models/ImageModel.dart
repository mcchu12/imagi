class ImageModel {
  final String id;
  final String description;
  final String url;

  ImageModel({this.id, this.description, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      description: json['description'],
      url: json['urls']['regular'],
    );
  }
}
