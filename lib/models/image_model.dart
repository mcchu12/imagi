class ImageModel {
  final String id;
  final String description;
  final String url;
  final int likes;
  final bool portrait;
  final Map<String, String> user;

  ImageModel(
      {this.id,
      this.description,
      this.url,
      this.likes,
      this.portrait,
      this.user});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        id: json['id'],
        description: json['description'],
        url: json['urls']['regular'],
        likes: json['likes'],
        portrait: json['height'] > json['width'],
        user: {
          'name': json['user']['name'],
          'username': json['user']['username'],
          'avatar': json['user']['profile_image']['medium']
        });
  }
}
