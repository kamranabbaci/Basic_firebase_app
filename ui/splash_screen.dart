import 'package:firebaseapp/firebase_services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}
class _SplashScreenState extends State<SplashScreen>{
  SplashService splashService = SplashService();
  @override
  void initState() {
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Firebase Tutorial", style: TextStyle(fontSize: 30),)),
    );
  }

}