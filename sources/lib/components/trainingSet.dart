import 'package:AthletiX/components/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter_svg/svg.dart';
import '../model/set.dart';

class TrainingSet extends StatelessWidget {
  final Set set;

  const TrainingSet({Key? key, required this.set}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: AppColors.greyMid,
      margin: EdgeInsets.only(
        top: screenHeight * 0.01,
        bottom: screenHeight * 0.01,
        left: screenWidth * 0.01,
        right: screenWidth * 0.01,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.015,
          bottom: screenHeight * 0.015,
        ),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.15), // 15% de la largeur
                1: FlexColumnWidth(0.3), // 30% de la largeur
                2: FlexColumnWidth(0.3), // 30% de la largeur
                3: FlexColumnWidth(0.15), // 15% de la largeur
              },
              children: [
                const TableRow(
                  children: [
                    Center(child: Text("Set", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Mode", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Weight", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Rep", style: TextStyle(color: Colors.white, fontSize: 16))),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                          child: Text("${set.id}",
                              style: const TextStyle(color: Colors.white))
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child:
                      Center(
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: DropdownButton<int>(
                            value: set.mode,
                            dropdownColor: AppColors.greyMid,
                            style: const TextStyle(color: Colors.orange), // Dropdown text color
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text("Progressive"),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Degressive"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("Normal"),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child:
                            Center(
                                child: Text(set.weight.join(', '),
                                    style: const TextStyle(color: Colors.white))
                            ),
                        ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.0001,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child:
                          Center(
                              child: Text("${set.reps}",
                                  style: const TextStyle(color: Colors.white)),
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Timer Row
            SizedBox(height: screenHeight * 0.02),
            Column(
              children: [
                const Text(
                  "Timer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GradientButton(
                          icon: SvgPicture.asset(
                            'assets/MinusIcon.svg',
                            width: screenWidth * 0.008,
                            height: screenHeight * 0.008,
                          ),
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.06,
                          onPressed: () {
                            print('Minus Button Pressed');
                          },
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(10.0), // Ajustez selon votre besoin
                        ),
                        padding: EdgeInsets.all(10.0), // Ajustez selon votre besoin
                        child: const Text(
                          "00:00:00",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Couleur du texte du timer
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GradientButton(
                          icon: SvgPicture.asset(
                            'assets/AddIcon.svg',
                            width: screenWidth * 0.035,
                            height: screenHeight * 0.035,
                          ),
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.06,
                          onPressed: () {
                            print('Add Button Pressed');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}