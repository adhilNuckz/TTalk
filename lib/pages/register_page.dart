import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttalk/const.dart';
import 'package:ttalk/servives/media_service.dart';
import 'package:ttalk/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance;
  late MediaService _mediaService;
  File? selectedImage;


  String? name , email ,  password ; 

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 223, 191, 28),
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
        children: [_headerText(), _regsiterForm()],
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
        child: Column(
         mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _priflePic(),
            CustomFormField(
                hintText: "Name" ,
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: NAME_VALIDATION_REGEX,
                onSaved: (value)  {
                   setState(() {
                      name = value ; 
                   });
                   }),

                    CustomFormField(
                hintText: "Email" ,
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: NAME_VALIDATION_REGEX,
                onSaved: (value)  {
                   setState(() {
                      email = value ; 
                   });
                   }) ,

                    CustomFormField(
                hintText: "Password" ,
                height: MediaQuery.of(context).size.height * 0.07,
                validationRegEx: NAME_VALIDATION_REGEX,
                onSaved: (value)  {
                   setState(() {
                      password = value ; 
                   });
                   })
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
}
