import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttalk/const.dart';
import 'package:ttalk/models/user_profile.dart';
import 'package:ttalk/servives/alert_services.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/database_service.dart';
import 'package:ttalk/servives/media_service.dart';
import 'package:ttalk/servives/navigation_service.dart';
import 'package:ttalk/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late MediaService _mediaService;
  late NavigationService _navigationService;
  late AuthService _authService;
  late DatabaseService _databaseService;
  late AlertServices _alertServices;

  File? selectedImage;

  bool isLoading = false;

  String? name, email, password;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _databaseService = _getIt.get<DatabaseService>();
    _alertServices = _getIt.get<AlertServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 203, 177, 48),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          _headerText(),
          if (!isLoading) _regsiterForm(),
          if (!isLoading) _loginAnAccountLink(),
          if (isLoading)
            const Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
        ],
      ),
    ));
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Talk",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          Text(
            "Register an account",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 18, 5, 5)),
          ),
        ],
      ),
    );
  }

  Widget _regsiterForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _priflePic(),
            CustomFormField(
                hintText: "Name",
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: NAME_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    name = value;
                  });
                }),
            CustomFormField(
                hintText: "Email",
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: EMAIL_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            CustomFormField(
                hintText: "Password",
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: NAME_VALIDATION_REGEX,
                obscureText: true,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _priflePic() {
    return GestureDetector(
      onTap: () async {
        XFile? xfile = await _mediaService.getImageFromGallery();
        File? file = xfile != null ? File(xfile.path) : null;
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.07,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            if ((_registerFormKey.currentState?.validate() ?? false)) {
              _registerFormKey.currentState?.save();

              bool result = await _authService.signup(email!, password!);

              if (result) {
                await _databaseService.createUserProfile(
                  UserProfile(
                    uid: _authService.user!.uid,
                    name: name!,
                  ),
                );
                _alertServices.showToast(
                    text: "Registered successfully", icon: Icons.check);
                _navigationService.goBack();
                _navigationService.pushReplacementNamed("/home");
              }
              // print(result);
            } else {
              print("Form is not valid");
              throw Exception("error occured unable to register");
            }
          } catch (e) {
            print(e);

            _alertServices.showToast(
                text: "Failed to register", icon: Icons.error);
          }

          setState(() {
            isLoading = false;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 42, 60, 195),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Register",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginAnAccountLink() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("Don't have an account?"),
        GestureDetector(
          onTap: () {
            _navigationService.goBack();
          },
          child: Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    ));
  }
}
