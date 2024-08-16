import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 40,),
            RoundButton(title: 'Forgot', onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                utils().toastMessage('We have sent you an email to recover password');

              }).onError((error, stackTrace){
                utils().toastMessage(error.toString());
              });
            })

          ],
        ),
      ),
    );
  }
}
