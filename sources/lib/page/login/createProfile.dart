import 'package:AthletiX/model/authentification/register.dart';
import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../../providers/api/clientApi.dart';

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

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
        final newProfile = await profileClientApi.createProfile(Profile(
          id: 0,
          email: profile.email,
          age: age,
          height: height,
          weight: weight,
          role: 0,
          uniqueNotificationToken: "",
          username: profile.username,
        ));
        AuthManager.setProfile(newProfile);
        Navigator.pushNamed(context, '/home');
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
