import 'package:AthletiX/exceptions/not_found_exception.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:AthletiX/providers/api/utils/exerciseClientApi.dart';

import '../main.dart';

class PublishPostPage extends StatefulWidget {
  @override
  _PublishPostPageState createState() => _PublishPostPageState();
}

class _PublishPostPageState extends State<PublishPostPage> {
  late List<Exercise> exercices;
  late List<Exercise> filteredExercices;
  final clientApi = getIt<ExerciseClientApi>();
  String searchQuery = '';

  bool isLoading = false;
  bool isLoadingCat = false;

  @override
  void initState() {
    super.initState();
    exercices = [];
    filteredExercices = [];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadExercices();
    });
  }

  void _loadExercices() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Exercise> fetchedExercices = await clientApi.getExercises();

      List<Exercise> filterExercices = fetchedExercices
          .where((exerc) =>
          exerc.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

      setState(() {
        filteredExercices = filterExercices;
        exercices = fetchedExercices;
        isLoading = false;
      });
    } on NotFoundException catch (_) {
      // Handle NotFoundException
      setState(() {
        exercices = []; // No exercises found
        isLoading = false;
      });
    }
  }

  Future<void> openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Ajoutez ici le code pour traiter la sélection de l'image (p. ex. l'afficher)
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF282828)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.04,
                child: Text(
                  'Add post',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                decoration: ShapeDecoration(
                  color: Color(0xE51A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white), // Texte en gris foncé
                  decoration: InputDecoration(
                    hintText: 'Post Name', // Placeholder
                    hintStyle: TextStyle(color: Colors.grey), // Couleur du placeholder
                    border: InputBorder.none, // Supprime la bordure par défaut
                    contentPadding: EdgeInsets.symmetric(horizontal: 20), // Ajoute un padding horizontal
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.1,
                decoration: ShapeDecoration(
                  color: Color(0xE51A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white), // Texte en gris foncé
                  maxLines: null, // Permet à l'utilisateur d'entrer plusieurs lignes de texte
                  decoration: InputDecoration(
                    hintText: 'Description', // Placeholder
                    hintStyle: TextStyle(color: Colors.grey), // Couleur du placeholder
                    border: InputBorder.none, // Supprime la bordure par défaut
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajoute un padding horizontal et vertical
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                decoration: ShapeDecoration(
                  color: Color(0xE51A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            // Update the filtered list of exercises based on the search query
                            filteredExercices = exercices
                                .where((exerc) => exerc.name
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                                .toList();
                          });
                        },
                        style: TextStyle(color: Colors.white), // Texte en gris foncé
                        decoration: InputDecoration(
                          hintText: 'Search', // Placeholder
                          hintStyle: TextStyle(color: Colors.grey), // Couleur du placeholder
                          border: InputBorder.none, // Supprime la bordure par défaut
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 20), // Ajoute un padding horizontal
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0), // Ajoute un padding uniquement à droite de l'icône
                      child: Icon(
                        Icons.search, // Icone à droite
                        color: Colors.grey, // Couleur de l'icône
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : filteredExercices.isEmpty
                          ? const Center(
                        child: Text(
                          "No Exercises Found",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Mulish',
                          ),
                        ),
                      )
                          : Column(
                        children: filteredExercices
                            .map((exercise) => ExerciseContainer(
                          exercice: exercise,
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  openImagePicker();
                },
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.08,
                  decoration: ShapeDecoration(
                    color: Color(0xE51A1A1A), // Couleur transparente pour laisser voir le contour pointillé
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid), // Contour gris pointillé
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0), // Ajoute un padding autour de l'icône
                        child: Icon(
                          Icons.folder, // Icône "addfile"
                          color: Colors.grey, // Couleur de l'icône
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Import Picture / Video', // Texte à droite de l'icône
                          style: TextStyle(color: Colors.grey), // Couleur du texte
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.06,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.92, -0.39),
                    end: Alignment(0.92, 0.39),
                    colors: [Color(0xFFA2E4E6), Color(0xFFB66CFF)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Publish', // Texte centré
                    style: TextStyle(
                      color: Colors.black, // Couleur du texte
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseContainer extends StatelessWidget {
  final Exercise exercice;

  const ExerciseContainer({required this.exercice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        exercice.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
