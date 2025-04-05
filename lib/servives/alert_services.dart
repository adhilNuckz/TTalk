import 'dart:ui';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/navigation_service.dart';

class AlertServices {
  final GetIt  _getIt = GetIt.instance;
  late  NavigationService _navigationService;
  late  AuthService _authService;



  AlertServices() {
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();

  }



     void showToast ({required  String text ,  IconData icon = Icons.info ,  }) {
     try {
      DelightToastBar(
        autoDismiss: true, 
        position: DelightSnackbarPosition.top  ,
      builder: (context) {
        return ToastCard(
          leading: Icon(
            icon,
            size: 30,
          ),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        );
      }).show(_navigationService.navigatorKey!.currentContext!); ;
       
     } catch (e) {
       print(e) ;
     }
  }
} 