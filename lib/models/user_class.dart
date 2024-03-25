class MyUsers {
  String? userName;
  String? imageUrl;
  String? userId;

  MyUsers({
    required this.userId,
    required this.imageUrl,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
