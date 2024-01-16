import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  final List<String> filters;

  FilterContainer({
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double dynamicWidth = screenWidth * 0.2;
    final double dynamicHeight = dynamicWidth * 0.4;
    final double dynamicFontSize = dynamicWidth * 0.2;

    Widget buildFilterItem(String filter) {
      return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gesture Detected!')),
          );
        },
        child: Container(
          width: dynamicWidth,
          height: dynamicHeight,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: dynamicWidth,
                  height: dynamicHeight,
                  decoration: ShapeDecoration(
                    color: Color(0xFF707070),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(dynamicWidth * 0.1),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: dynamicWidth * 0.04,
                        offset: Offset(0, dynamicWidth * 0.04),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: dynamicWidth * 0.072,
                top: dynamicHeight * 0.15,
                child: SizedBox(
                  width: dynamicWidth * 0.833,
                  height: dynamicHeight * 0.91,
                  child: Text(
                    filter,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: dynamicFontSize,
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
      color:  Color(0xFF151515).withOpacity(0.9),
      child: Column(
      children: [
          GridView.builder(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenHeight * 0.05,screenWidth * 0.01, 0),
            shrinkWrap: true,
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,

            ),
            itemCount: filters.length,
            itemBuilder: (BuildContext context, int index) {
              return buildFilterItem(filters[index]);
            },
          ),
        ],
      ),
    );
  }
}
