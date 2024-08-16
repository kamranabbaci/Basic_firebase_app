import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/posts/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../util/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool  loading = false;
  final verifyCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Verify", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: verifyCodeController,
              decoration: const InputDecoration(
                labelText: "6-digit code",
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(title: "Verify", loading: loading, onTap: () async {
              setState(() {
                loading = true;
              });
              final credentials = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyCodeController.text.toString());
              try{
                await _auth.signInWithCredential(credentials);
                setState(() {
                  loading = false;
                });

              }catch(e){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const PostsScreen()));
                setState(() {
                  loading = false;
                });
                utils().toastMessage(e.toString());
              }


            }),

          ],
        ),
      ),
    );
  }
}
