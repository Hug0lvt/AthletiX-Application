import 'dart:convert';
import 'dart:io';

import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../model/profile.dart';
import '../providers/localstorage/secure/authManager.dart';


class EditProfileContainer extends StatefulWidget {
  final VoidCallback onClose;

  EditProfileContainer({required this.onClose});

  @override
  _EditProfileContainerState createState() => _EditProfileContainerState();
}

class _EditProfileContainerState extends State<EditProfileContainer> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String userPicture = "";
  List<bool> _selectedGender = [true, false];
  var gender = false;

  Profile? _profile;
  void fetchProfile() async {
    // Call your method to fetch the profile
    Profile? profile = await AuthManager.getProfile();
    setState(() {
      _profile = profile;
    });
    if(_profile != null){
      pseudoController.text = _profile?.username ?? 'Unknown';
      ageController.text = _profile?.age.toString() ?? 'Unknown';
      heightController.text = _profile?.height.toString() ?? '0';
      weightController.text = _profile?.weight.toString() ?? '0';
      if(_profile!.gender!){
        gender = true;
        _selectedGender = [false, true];
      }else{
        gender = false;
        _selectedGender = [true, false];
      }
      userPicture = _profile?.picture ?? "";
    }
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
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.05),
      child: Column(
        children: [
          buildTextInputWithSpacing("Pseudo", "Enter your new username", screenWidth, pseudoController),
          buildTextInputWithSpacing("Age", "Enter your age", screenWidth, ageController),
          buildTextInputWithSpacing("Height", "Enter your height", screenWidth, heightController),
          buildTextInputWithSpacing("Weight", "Enter your weight", screenWidth, weightController),
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
              selectedColor: Colors.blue,
              fillColor: Colors.grey[200],
              color: Colors.grey[400],
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
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              decoration: ShapeDecoration(
                color: Color(0xE51A1A1A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid), // Contour gris pointillé
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0), // Ajoute un padding autour de l'icône
                    child: Icon(
                      Icons.folder, // Icône "addfile"
                      color: Colors.grey, // Couleur de l'icône
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Import Profile Picture (1:1)', // Texte à droite de l'icône
                      style: TextStyle(color: Colors.grey), // Couleur du texte
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          buildSubmitButton(screenWidth),
        ],
      ),
    );
  }

  Widget buildTextInputWithSpacing(String label, String placeholder, double screenWidth, TextEditingController controller) {
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
              controller: controller,
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
          submitForm();
        },
        style: ElevatedButton.styleFrom(

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

  void submitForm() async {
    Profile updatedProfile = Profile();
    if(_profile != null) updatedProfile = _profile!;
    String? pseudo = pseudoController.value.text;
    int? age = int.tryParse(ageController.value.text);
    int? weight = int.tryParse(weightController.value.text);
    int? height = int.tryParse(heightController.value.text);
    if(pseudo.isEmpty || age == null || weight == null || height == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one of the fields is empty! (without genre and picture)'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    updatedProfile.username = pseudo;
    updatedProfile.age = age;
    updatedProfile.weight = weight;
    updatedProfile.height = height;
    updatedProfile.gender = gender;
    updatedProfile.picture = userPicture;

    try {
      await getIt<ProfileClientApi>().updateProfile(updatedProfile.id!, updatedProfile);
      await AuthManager.setProfile(updatedProfile);
      widget.onClose();
    } catch (e) {
      print("Error updating profile: $e");
      widget.onClose();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }
}
