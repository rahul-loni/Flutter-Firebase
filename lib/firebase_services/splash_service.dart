import 'dart:async';

import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
