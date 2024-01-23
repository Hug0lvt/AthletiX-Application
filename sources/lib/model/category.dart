class Category {
  int id;
  String title;

  Category({required this.id, required this.title});
  Category.partial({this.id = 0, this.title = ''});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
