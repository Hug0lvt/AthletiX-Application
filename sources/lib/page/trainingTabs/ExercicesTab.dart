import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:AthletiX/components/ExerciseContainer.dart';
import 'package:AthletiX/components/FilterContainer.dart';
import 'package:AthletiX/exceptions/not_found_exception.dart';
import 'package:AthletiX/model/category.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/providers/api/utils/categoryClientApi.dart';
import 'package:AthletiX/providers/api/utils/exerciseClientApi.dart';
import 'package:AthletiX/main.dart';

class ExercicesTab extends StatefulWidget {
  const ExercicesTab({Key? key}) : super(key: key);

  @override
  State<ExercicesTab> createState() => _ExercicesTab();
}

class _ExercicesTab extends State<ExercicesTab> {
  final clientApi = getIt<ExerciseClientApi>();
  final clientCategoryApi = getIt<CategoryClientApi>();

  late List<Exercise> exercices;
  late List<Category> categories;

  bool isLoading = false;
  bool isLoadingCat = false;

  late List<Exercise> filteredExercices;
  String searchQuery = '';

  @override
  void initState() {
    categories = [];
    exercices = [];
    filteredExercices = [];
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadExercices();
      _loadCategories();
    });
  }

  void _loadExercices() async {
    setState(() {
      isLoading = true;
    });
    try {
       List<Exercise> fetchedExercices = await clientApi.getExercises();
      /*List<Exercise> fetchedExercices = [
        Exercise(
          id: 0,
          name: "Push-ups",
          description: "Perform 3 sets of 15 push-ups",
          image: "",
          category: Category(id: 0, title: "Chest"),
          sets: [],
        ),
        Exercise(
          id: 1,
          name: "Dumbell press",
          description: "Perform 3 sets of 15 push-ups",
          image: "",
          category: Category(id: 1, title: "Chest 2"),
          sets: [],
        )
      ];*/

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

  void _loadCategories() async {
    setState(() {
      isLoadingCat = true;
    });
    try {
      List<Category> fetchedCategories =
      await clientCategoryApi.getCategories();
      setState(() {
        categories = fetchedCategories;
        isLoadingCat = false;
      });
    } on NotFoundException catch (_) {
      // Handle NotFoundException
      setState(() {
        categories = []; // No categories found
        isLoadingCat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void onPressed() {
      showModalBottomSheet<int>(
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: Colors.black87,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Filters',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontFamily: 'Mulish',
                  ),
                ),
                FilterContainer(
                  filters: categories,
                  color: Colors.white24,
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        color: const Color(0xFF282828),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      screenWidth * 0.045, 0, screenWidth * 0.02, 0),
                  width: screenWidth * 0.8,
                  child: Stack(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            // Update the filtered list of exercises based on the search query
                            filteredExercices = exercices.where((exerc) =>
                                exerc.name.toLowerCase().contains(searchQuery.toLowerCase())
                            ).toList();
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              'assets/MagGlass.svg',
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: onPressed,
                    icon: SvgPicture.asset('assets/Filter.svg'),
                    padding:
                    EdgeInsets.fromLTRB(0, screenWidth * 0.01, 0, 0))
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'Exercises',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                shrinkWrap: true,
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
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredExercices.length,
                    itemBuilder: (context, index) {
                      return ExerciseContainer(
                        exercice: filteredExercices[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
