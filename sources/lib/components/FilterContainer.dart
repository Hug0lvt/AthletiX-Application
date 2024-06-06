import 'package:AthletiX/model/category.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatefulWidget {
  final List<Category> filters;
  final Color color;
  final List<Category>  selectedFilters;
  final Function(List<Category> ) onFilterChanged;

  FilterContainer({
    required this.filters,
    required this.color,
    required this.selectedFilters,
    required this.onFilterChanged,
  });

  @override
  _FilterContainerState createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  late List<Category>  filtersSelected;

  @override
  void initState() {
    super.initState();
    filtersSelected = widget.selectedFilters;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dynamicWidth = screenWidth * 0.2;

    Widget buildFilterItem(Category filter) {
      bool isSelected = filtersSelected.contains(filter);
      Color itemColor = isSelected ? Colors.green : widget.color;

      return GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              filtersSelected.remove(filter);
            } else {
              filtersSelected.add(filter);
            }
            widget.onFilterChanged(filtersSelected);
          });
        },
        child: SizedBox(
          width: dynamicWidth,
          child: Stack(
            children: [
              Container(
                width: dynamicWidth,
                decoration: BoxDecoration(
                  color: itemColor,
                  borderRadius: BorderRadius.circular(dynamicWidth * 0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: dynamicWidth * 0.04,
                      offset: Offset(0, dynamicWidth * 0.04),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: dynamicWidth * 0.072,
                top: dynamicWidth * 0.05,
                child: SizedBox(
                  width: dynamicWidth * 0.833,
                  height: dynamicWidth * 0.91,
                  child: Text(
                    filter.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: dynamicWidth * 0.2,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenHeight * 0.05, screenWidth * 0.01, 0),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dynamicWidth * 1.2,
          mainAxisSpacing: dynamicWidth * 0.2,
          crossAxisSpacing: 0,
          childAspectRatio: dynamicWidth * 0.035,
        ),
        itemCount: widget.filters.length,
        itemBuilder: (BuildContext context, int index) {
          return buildFilterItem(widget.filters[index]);
        },
      ),
    );
  }
}
