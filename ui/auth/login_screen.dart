
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_with_phone_number.dart';
import 'package:firebaseapp/ui/auth/signup_screen.dart';
import 'package:firebaseapp/ui/forgot_password.dart';
import 'package:firebaseapp/ui/posts/posts_screen.dart';
import 'package:firebaseapp/ui/upload_image.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((onValue){
      utils().toastMessage(onValue.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadImageScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, handleError){
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        helperText: "Enter your email",
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter email";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        helperText: "Enter your password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter password";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                ],
              )
            ),
            const SizedBox(height: 50,),
            RoundButton(title: "Login", loading: loading, onTap: (){
              if(_formKey.currentState!.validate()){
                login();
              }
            },
            ),
            const SizedBox(height: 30,),

            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
              }, child: const Text("Forgot Password?"),
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                }, child: const Text("Sign up"))
              ],
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginWithPhoneNumber()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(child: Text("Login with phone number")),),
            )
          ],
        ),
      ),
    );
  }
}