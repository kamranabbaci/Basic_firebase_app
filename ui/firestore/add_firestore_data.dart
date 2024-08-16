import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});


  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Firestore Post", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: postController,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "What's in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            RoundButton(title: "Add", loading: loading, onTap: (){
              setState(() {
                loading = true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({
                'title': postController.text.toString(),
                'id': id
              }).then((value){
                setState(() {
                  loading = false;
                });
                utils().toastMessage('Post added');

              }).onError((error, stackTrace){
                setState(() {
                  loading = false;
                });
                utils().toastMessage("error");
              });

            })


          ],
        ),
      ),
    );
  }

}
