import 'dart:convert';
import 'dart:io';

import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({super.key});
  @override
  State<CreateProfileForm> createState() => CreateProfilePage();
}

class CreateProfilePage extends State<CreateProfileForm> {

  final profileClientApi = getIt<ProfileClientApi>();

  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  List<bool> _selectedGender = [true, false];
  var gender = false;
  String userPicture = "";

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      userPicture = base64Encode(imageBytes);
    } else {
      print('Aucune image sélectionnée.');
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SvgPicture.asset('assets/AthletiX.svg', width: width*0.8),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age (Years)',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight (Kg)',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (Cm)',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selectedGender.length; i++) {
                        _selectedGender[i] = i == index;
                      }
                      if(_selectedGender[0]) gender = false;
                      if(_selectedGender[1]) gender = true;
                      print(gender);
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.blue[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.blue[200],
                  color: Colors.blue[400],
                  isSelected: _selectedGender,
                  children: <Widget>[
                    Icon(Icons.female),
                    Icon(Icons.male),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  openImagePicker();
                },
                child: Container(
                  width: width * 0.8,
                  height: screenHeight * 0.08,
                  decoration: ShapeDecoration(
                    color: Colors.deepPurple, // Couleur transparente pour laisser voir le contour pointillé
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.purple, width: 1.0, style: BorderStyle.solid), // Contour gris pointillé
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0), // Ajoute un padding autour de l'icône
                        child: Icon(
                          Icons.folder, // Icône "addfile"
                          color: Colors.white, // Couleur de l'icône
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Import Profile Picture (1:1)', // Texte à droite de l'icône
                          style: TextStyle(color: Colors.white), // Couleur du texte
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  createProfile();
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createProfile() async {
    int? age = int.tryParse(ageController.value.text);
    int? weight = int.tryParse(weightController.value.text);
    int? height = int.tryParse(heightController.value.text);

    if (age == null || weight == null || height == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one of the fields is empty!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    try {
      final profile = await AuthManager.getProfile();
      if (profile != null && profile.email != null && profile.username != null) {
        final midProfile = await profileClientApi.createProfile(Profile(
          id: 0,
          email: profile.email,
          age: age,
          height: height,
          weight: weight,
          role: 0,
          uniqueNotificationToken: "",
          username: profile.username,
          gender: gender,
          picture: userPicture,
        ));
        final newProfile = await profileClientApi.getProfileByEmail(midProfile.email!);
        AuthManager.setProfile(newProfile);
        Navigator.pushNamedAndRemoveUntil(context, '/navbar', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error with profile !'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }


}
