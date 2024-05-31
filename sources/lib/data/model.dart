class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/video.png', name: 'Videos'),
  Model(id: 1, imagePath: 'assets/search.png', name: 'Search'),
  Model(id: 2, imagePath: 'assets/plus.png', name: 'New'),
  Model(id: 3, imagePath: 'assets/chat.png', name: 'Messages'),
  Model(id: 4, imagePath: 'assets/person.png', name: 'Profile'),
  Model(id: 5, imagePath: 'assets/dumbbell.png', name: 'Training'),
];