import 'package:flutter/material.dart';

class EditProfileContainer extends StatelessWidget {
  final VoidCallback onClose;

  EditProfileContainer({required this.onClose});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.05),
      child: Column(
        children: [
          buildTextInputWithSpacing("Pseudo", "Enter your new username", screenWidth),
          buildTextInputWithSpacing("Height", "Enter your height", screenWidth),
          buildTextInputWithSpacing("Weight", "Enter your weight", screenWidth),

          buildSubmitButton(screenWidth),
        ],
      ),
    );
  }

  Widget buildTextInputWithSpacing(String label, String placeholder, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: screenWidth * 0.1),
      width: screenWidth * 0.35,
      height: screenWidth * 0.14,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB66CFF), Color(0xFFA2E4E6)],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          onClose();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Container(
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
            ),
          ),
        ),
      ),
    );
  }


}
