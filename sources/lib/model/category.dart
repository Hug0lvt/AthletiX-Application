import 'dart:convert';

List<Category> categoryListFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));
Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
