import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post", style: TextStyle(color: Colors.white),),
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

              String id = DateTime.now().microsecondsSinceEpoch.toString();

              databaseRef.child(id).set({
                'title': postController.text.toString(),
                'id' : id,
              }).then((onValue){
                setState(() {
                  loading = false;
                });

                utils().toastMessage("Post Added");

              }).onError((error, stackTrace){
                setState(() {
                  loading = false;
                });
                utils().toastMessage(error.toString());
              });

            })


          ],
        ),
      ),
    );
  }

}
