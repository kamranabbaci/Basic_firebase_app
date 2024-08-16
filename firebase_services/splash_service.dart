import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/ui/upload_image.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 2), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UploadImageScreen()));
      });
    }
    else{
      Timer(const Duration(seconds: 2), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }
}