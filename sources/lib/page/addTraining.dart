import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/localstorage/secure/authKeys.dart';
import '../providers/localstorage/secure/authManager.dart';

class AddTrainingPage extends StatefulWidget {
  @override
  _AddTrainingPageState createState() => _AddTrainingPageState();
}

class _AddTrainingPageState extends State<AddTrainingPage> {
  TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: const Color(0xFF1B1B1B),
        title: SvgPicture.asset('assets/AthletiX.svg'),
        titleSpacing: -40,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
      ),
      body: Container(
        color: AppColors.greyDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Name your program.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    _isButtonEnabled = value.isNotEmpty;
                  });
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () async {
                String? token = await AuthManager.getToken(AuthKeys.ATH_BEARER_TOKEN_API.name);
                print(token);
                String programName = _controller.text;
              }
                  : null,
              child:
              Text(
                'Create',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}