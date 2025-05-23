import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttalk/pages/login_page.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/navigation_service.dart';
import 'package:ttalk/utils.dart';

void main() async{

   

  await setup();
  runApp( MyApp());
}

Future<void> setup () async {
 WidgetsFlutterBinding.ensureInitialized();
 await  setupFirebase() ;
 await registerServices() ;
}

class MyApp extends StatelessWidget {

  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthService _authService;
  


   MyApp({super.key}) {
    _navigationService = _getIt.get<NavigationService>();
    _authService =  _getIt.get<AuthService>();
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 93, 0, 255)),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoMonoTextTheme(),

      ),
    initialRoute: _authService.user != null ? "/home" : "/login",
      routes: _navigationService.routes,
    );
  }
}
