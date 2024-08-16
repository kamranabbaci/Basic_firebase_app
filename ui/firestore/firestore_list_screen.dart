import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import '../../util/utils.dart';
import '../auth/login_screen.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {

  final _auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Posts Screen", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((onValue){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

            }).onError((error, stackTrace) {
              utils().toastMessage(error.toString());
            });
          },
              icon: const Icon(Icons.logout, color: Colors.white,)),
          const SizedBox(width: 20,),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          StreamBuilder <QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }
                if(snapshot.hasError){
                  return const Text("Error");
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                    return ListTile(
                      onTap: (){
                        // ref.doc(snapshot.data!.docs[index]['id'].toString()).update(
                        //     {
                        //       'title': 'kamran'
                        //     }).then((onValue){
                        //       utils().toastMessage('Updated');
                        //
                        //     }).onError((error,stackTrace){
                        //       utils().toastMessage(error.toString());
                        //
                        // });
                        //ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                      },
                      title: Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  }),
                );

              })

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddFirestoreDataScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialog(String title, String id) async{
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: const Text("Cancel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: const Text("Update"))
            ],
          );
        }
    );
  }
}
