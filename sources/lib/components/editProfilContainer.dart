import 'package:flutter/material.dart';

class EditProfileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.05),
      child: Column(
        children: [
          // Ajoutez des TextInputs avec espacement
          buildTextInputWithSpacing("Nom", "Entrez votre nom"),
          buildTextInputWithSpacing("Prénom", "Entrez votre prénom"),
          buildTextInputWithSpacing("Email", "Entrez votre email"),

          // Ajoutez d'autres TextInputs selon vos besoins

          // Ajoutez un bouton Valider tout en bas
          buildSubmitButton(),
        ],
      ),
    );
  }

  Widget buildTextInputWithSpacing(String label, String placeholder) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            width: double.infinity, // prend toute la largeur disponible
            child: TextField(
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: ElevatedButton(
        onPressed: () {
          // Logique de validation ici
        },
        child: Text(
          'Valider',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
}
