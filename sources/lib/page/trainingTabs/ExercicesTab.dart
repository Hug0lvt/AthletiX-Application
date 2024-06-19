import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:AthletiX/components/ExerciseContainer.dart';
import 'package:AthletiX/components/FilterContainer.dart';
import 'package:AthletiX/exceptions/not_found_exception.dart';
import 'package:AthletiX/model/category.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/providers/api/utils/categoryClientApi.dart';
import 'package:AthletiX/providers/api/utils/exerciseClientApi.dart';
import 'package:AthletiX/main.dart';

class ExercicesTab extends StatefulWidget {
  final Function(Exercise)? onExerciseSelected;

  const ExercicesTab({Key? key, this.onExerciseSelected}) : super(key: key);

  @override
  _ExercicesTabState createState() => _ExercicesTabState();
}

class _ExercicesTabState extends State<ExercicesTab> {
  final clientApi = getIt<ExerciseClientApi>();
  final clientCategoryApi = getIt<CategoryClientApi>();

  late List<Exercise> exercices;
  late List<Category> categories;

  bool isLoading = false;
  bool isLoadingCat = false;

  late Map<Category, List<Exercise>> groupedExercises;
  String searchQuery = '';
  List<Category> filtersSelected = [];

  @override
  void initState() {
    categories = [];
    exercices = [];
    groupedExercises = {};
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
      _applyFilters(fetchedExercices);
      setState(() {
        exercices = fetchedExercices;
        isLoading = false;
      });
    } on NotFoundException catch (_) {
      setState(() {
        exercices = [];
        isLoading = false;
      });
    }
  }

  void _loadCategories() async {
    setState(() {
      isLoadingCat = true;
    });
    try {
      List<Category> fetchedCategories = await clientCategoryApi.getCategories();
      setState(() {
        categories = fetchedCategories;
        isLoadingCat = false;
      });
    } on NotFoundException catch (_) {
      setState(() {
        categories = [];
        isLoadingCat = false;
      });
    }
  }
  void _applyFilters(List<Exercise> exercises) {
    Map<Category, List<Exercise>> grouped = {};


    for (var exercise in exercises) {
      bool matchesSearch = exercise.name.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = filtersSelected.isEmpty;
      if(!matchesFilter){
        for( var filter in filtersSelected){
          if(exercise.category != null && exercise.category!.id == filter.id){
            matchesFilter = true;
          }
        }
      }

      if (matchesSearch && matchesFilter) {
          if (!grouped.containsKey(exercise.category)) {
              grouped[exercise.category!] = [];
          }
          grouped[exercise.category]!.add(exercise);

      }
    }

    setState(() {
      groupedExercises = grouped;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
      _applyFilters(exercices);
    });
  }

  void _onFilterChanged(List<Category> selectedFilters) {
    setState(() {
      filtersSelected = selectedFilters;
      _applyFilters(exercices);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void onPressed() {
      showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.black87,
        context: context,
        builder: (context) {
          return Container(
            height: screenHeight * 0.7, // 70% of screen height
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, screenHeight * 0.03, 0, 0)),
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
                  selectedFilters: filtersSelected,
                  onFilterChanged: _onFilterChanged,
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
                        onChanged: _onSearchChanged,
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
                    padding: EdgeInsets.fromLTRB(0, screenWidth * 0.01, 0, 0))
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
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : groupedExercises.isEmpty
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
                itemCount: groupedExercises.length,
                itemBuilder: (context, index) {
                  Category category = groupedExercises.keys.elementAt(index);
                  List<Exercise> exercises = groupedExercises[category]!;
                  return ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      category.title,
                      style: TextStyle(color: Colors.white, fontFamily: 'Mulish'),
                    ),
                    children: exercises.map((exercise) {
                      return ExerciseContainer(
                        exercice: exercise,
                        onExerciseSelected: widget.onExerciseSelected,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
