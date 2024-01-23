import 'category.dart';
import 'set.dart';

class Exercise {
  int id;
  String name;
  String description;
  String image;
  Category category;
  List<Set> sets;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    this.sets = const [],
  });

  Exercise.partial({
    int? id,
    String? name,
    String? description,
    String? image,
    Category? category,
    List<Set>? sets,
  })  : id = id ?? 0,
        name = name ?? '',
        description = description ?? '',
        image = image ?? '',
        category = category ?? Category.partial(),
        sets = sets ?? [];

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      sets: (json['sets'] as List<dynamic>?)
          ?.map((set) => Set.fromJson(set as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category.toJson(),
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }
}
