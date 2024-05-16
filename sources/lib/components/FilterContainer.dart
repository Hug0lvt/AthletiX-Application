import 'package:AthletiX/model/category.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  final List<Category> filters;
  final Color color;

  FilterContainer({
    required this.filters,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dynamicWidth = screenWidth * 0.2;

    Widget buildFilterItem(Category filter) {
      return GestureDetector(
        onTap: () {
            filters.remove(filter);
        },
        child: SizedBox(
          width: dynamicWidth,
          child: Stack(
            children: [
              Container(
                width: dynamicWidth,
                decoration: BoxDecoration(
                  color: color,
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
        itemCount: filters.length,
        itemBuilder: (BuildContext context, int index) {
          return buildFilterItem(filters[index]);
        },
      ),
    );
  }
}