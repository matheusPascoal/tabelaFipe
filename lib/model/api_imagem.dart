class ApiImage {
  String? imageUrl;

  ApiImage({this.imageUrl});

  ApiImage.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }
}
