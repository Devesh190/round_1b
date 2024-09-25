class Comment {
  String name;
  String email;
  String body;

  Comment({required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
        name: data['name'], email: data['email'], body: data['body']);
  }
}
