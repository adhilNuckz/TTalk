import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ttalk/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ttalk/servives/alert_services.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/media_service.dart';
import 'package:ttalk/servives/navigation_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),

  );

  getIt.registerSingleton<NavigationService>(
    NavigationService(),
    
  );

   getIt.registerSingleton<MediaService>(
    MediaService(),
    
  );

    getIt.registerSingleton<AlertServices>(AlertServices());


  

}
