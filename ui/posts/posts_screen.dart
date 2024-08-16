import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/ui/posts/add_posts.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFieldController = TextEditingController();
  final editController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Screen", style: TextStyle(color: Colors.white),),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: searchFieldController,
              decoration: const InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),

          const SizedBox(height: 20,),


          // feteching data using Stream Builder
          // code present below be pasted here



          // feteching data using FirebaseAnimated List
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index){

                  final title = snapshot.child('title').value.toString();
                  if(searchFieldController.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(title,snapshot.child('id').value.toString());
                                  },
                                  leading: const Icon(Icons.edit),
                                  title: const Text("Edit"),
                            )
                          ),
                            PopupMenuItem(
                              value: 2,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  leading: const Icon(Icons.delete),
                                  title: const Text("Delete"),
                                )
                            )
                        ]
                      ),
                    );
                  }
                  else if(title.toLowerCase().contains(searchFieldController.text.toLowerCase())){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),

                    );
                  }
                  else{
                    return Container();
                  }
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostsScreen()));
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
                ref.child(id).update({
                  'title' : editController.text.toString()
                }).then((onValue){
                  utils().toastMessage('Post Updated');
                }).onError((error, stackTrace){
                  utils().toastMessage(error.toString());
                });
              },
                  child: const Text("Update"))
            ],
          );
        }
    );
  }
}



/*Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
              if (!snapshot.hasData)
              {
                return Center(
                    child: SizedBox(
                        height:20,
                        width: 20,
                        child: CircularProgressIndicator()));
              }
              else
              {
                Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(list[index]['title']),
                        subtitle: Text(list[index]['id']),
                      );
                    });
              }

            },
          )),*/