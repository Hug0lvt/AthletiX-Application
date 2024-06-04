import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:flutter/material.dart';
import '../main.dart';


class EditProfileContainer extends StatefulWidget {
  final VoidCallback onClose;

  EditProfileContainer({required this.onClose});

  @override
  _EditProfileContainerState createState() => _EditProfileContainerState();
}

class _EditProfileContainerState extends State<EditProfileContainer> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileClientApi = getIt<ProfileClientApi>();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.05),
      child: Column(
        children: [
          buildTextInputWithSpacing("Pseudo", "Enter your new username", screenWidth, pseudoController),
          buildTextInputWithSpacing("Height", "Enter your height", screenWidth, heightController),
          buildTextInputWithSpacing("Weight", "Enter your weight", screenWidth, weightController),
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
    // TODO a finir (await AuthManager.getProfile)
    /*Profile updatedProfile = Profile(
      id: 0, // localStorageUser.id
      username: pseudoController.text,
      mail: '', // localStorageUser.mail
      uniqueNotificationToken: '', // localStorageUser.notificationToken
      role: Role.user, // localStorageUser.role
      age: 0, // localStorageUser.age
      email: '', // localStorageUser.email
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
    );

    int profileId = 123; // Replace with the actual profile ID

    try {
      await profileApiClient.updateProfile(profileId, updatedProfile);
      widget.onClose();
    } catch (e) {
      print("Error updating profile: $e");
      widget.onClose();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }*/
  }
}
