import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  final contactNumber = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Sign up", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          labelText: "First Name",
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Enter First Name";
                          }
                          else {
                            return null;
                          }
                        },

                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: lastName,
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Last Name";
                          }
                          else {
                            return null;
                          }
                        }
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            else {
                              return null;
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            else {
                              return null;
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: repeatPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Repeat Password",
                        ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Renter Password";
                            }
                            else {
                              return null;
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: contactNumber,
                        decoration: const InputDecoration(
                          labelText: "Contact Number",
                        ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Contact Number";
                            }
                            else {
                              return null;
                            }
                          }
                      ),
                    ],
                  )),
              const SizedBox(height: 50,),
              RoundButton(
                title: "Sign up",
                loading: loading,
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    _auth.createUserWithEmailAndPassword(
                        email: email.text.toString(),
                        password: password.text.toString()).then((value){
                          setState(() {
                            loading = false;
                          });

                    }).onError((error, stackTrace){
                      utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });

                    });
                  }
                },
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }, child: const Text("Login")),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}

