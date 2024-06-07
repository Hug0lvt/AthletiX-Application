import 'dart:io';

import 'package:AthletiX/exceptions/not_found_exception.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:AthletiX/providers/api/utils/exerciseClientApi.dart';

import '../components/ExerciseContainer.dart';
import '../main.dart';
import '../model/category.dart';
import '../model/post.dart';
import '../providers/api/utils/categoryClientApi.dart';
import '../providers/api/utils/postClientApi.dart';
import '../providers/localstorage/secure/authManager.dart';


class PublishPostPage extends StatefulWidget {
  @override
  _PublishPostPageState createState() => _PublishPostPageState();
}

class _PublishPostPageState extends State<PublishPostPage> {
  Profile? _profile;
  late List<Exercise> exercices;
  late List<Exercise> selectedExercises;
  late List<Exercise> filteredExercices;
  late List<Category> categories;
  late Category selectedCategory;
  final categoryClientApi = getIt<CategoryClientApi>();
  final clientApi = getIt<ExerciseClientApi>();
  final postClientApi = getIt<PostClientApi>();
  String searchQuery = '';
  File? _selectedMediaFile;

  bool isLoading = false;
  bool isLoadingCat = false;

  // Controllers pour capturer les valeurs des champs de saisie
  final TextEditingController postNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
    exercices = [];
    selectedExercises = [];
    filteredExercices = [];
    categories = [];
    selectedCategory = Category(id: 0, title: "");
    _loadCategories();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadExercices();
    });
  }

  Future<void> _loadProfile() async {
    Profile? profile = await AuthManager.getProfile();
    setState(() {
      _profile = profile;
    });
  }

  void _loadExercices() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Exercise> fetchedExercices = await clientApi.getExercises();
      setState(() {
        exercices = fetchedExercices;
        isLoading = false;
        _filterExercices();
      });
    } on NotFoundException catch (_) {
      // Handle NotFoundException
      setState(() {
        exercices = []; // No exercises found
        selectedExercises = [];
        isLoading = false;
        _filterExercices();
      });
    }
  }

  Future<void> _loadCategories() async {
    try {
      final loadedCategories = await categoryClientApi.getCategories();
      setState(() {
        categories = loadedCategories;
        selectedCategory = categories[0];
      });
    } catch (e) {
      // Gérez les erreurs en cas d'échec du chargement des catégories
      print("Failed to load categories: $e");
    }
  }

  void _filterExercices() {
    filteredExercices = exercices
        .where((exerc) =>
        exerc.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Add code here to handle the selected image (e.g., display it)
  }

  Future<void> openVideoPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedMediaFile = File(pickedFile.path);
      });
    }
  }

  void _toggleExerciseSelection(int index) {
    setState(() {
      final exercise = filteredExercices[index];
      if (selectedExercises.contains(exercise)) {
        selectedExercises.remove(exercise);
      } else {
        selectedExercises.add(exercise);
      }
    });
  }

  Future<void> _publishPost() async {
    // Créez un objet Post avec les données des champs remplis par l'utilisateur
    final post = Post(
      publisher: _profile,
      category: selectedCategory,
      title: postNameController.text,  // Utilisez la valeur du champ "Post Name"
      description: descriptionController.text,  // Utilisez la valeur du champ "Description"
      publicationType: 0,
      content: "",
      comments: [],
      exercises: [],
      id: 0,
    );

    try {
      // Créez le post
      final createdPost = await postClientApi.createPost(post);

      // Si un fichier média est sélectionné, téléchargez-le
      if (_selectedMediaFile != null) {
        try {
          await postClientApi.uploadPostMedia(createdPost.id, _selectedMediaFile!);
          print("Media uploaded successfully");
        } catch (e) {
          print("Failed to upload media: $e");
        }
      }

      // Affichez un message ou effectuez d'autres actions si nécessaire après la publication réussie du post
      print("Post published successfully: ${createdPost.id}");
    } catch (e) {
      // Gérez les erreurs en cas d'échec de la publication du post
      print("Failed to publish post: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      body: SingleChildScrollView(
        child: Container(
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
                    controller: postNameController,  // Ajoutez le contrôleur
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Post Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                    controller: descriptionController,  // Ajoutez le contrôleur
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                  child: DropdownButtonFormField<Category>(
                    value: selectedCategory,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    onChanged: (Category? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categories.map<DropdownMenuItem<Category>>((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.title),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
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
                          children: filteredExercices.asMap().entries.map((entry) {
                            final index = entry.key;
                            final exercise = entry.value;
                            return GestureDetector(
                              onTap: () {
                                _toggleExerciseSelection(index);
                              },
                              child: ExerciseContainer(
                                exercice: exercise,),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.08,
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedExercises.length,
                      itemBuilder: (context, index) {
                        final exercise = selectedExercises[index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Chip(
                            label: Text(
                              exercise.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0xE51A1A1A),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    openVideoPicker();
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.08,
                    decoration: ShapeDecoration(
                      color: Color(0xE51A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.folder,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Import Picture / Video',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _publishPost,  // Ajoutez cette ligne pour appeler la méthode _publishPost
                  child: Container(
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
                        'Publish',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
