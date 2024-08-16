import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/verify_code.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool  loading = false;
  final phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Login", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(title: "Login", loading: loading, onTap: (){

              setState(() {
                loading = true;
              });

              _auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                  setState(() {
                    loading = false;
                  });
                  },
                  verificationFailed: (e){
                  utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                  },
                  codeSent: (String verificationId, int? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId)));
                  setState(() {
                    loading = false;
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                  utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                  });
            })
          ],
        ),
      ),
    );
  }
}
