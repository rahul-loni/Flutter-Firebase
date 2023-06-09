import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/login_screen.dart';
import 'package:firebase_flutter/ui/home_screen.dart';
import 'package:firebase_flutter/ui/upload_image.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadImage(),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
  }
}
