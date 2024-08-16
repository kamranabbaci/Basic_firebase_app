import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/util/utils.dart';
import 'package:firebaseapp/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  bool loading = false;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Post');
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }
      else{
        print('No file is selected');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImage();
                },
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      )
                  ),
                  child: _image !=null ? Image.file(_image!.absolute):
                  const Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            RoundButton(title: 'Upload Image', loading: loading, onTap: () async {
              setState(() {
                loading = true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage
                  .instance.ref('/folder' 'pic');
              firebase_storage.UploadTask uploadTask = ref.putFile(
                  _image!.absolute);
              Future.value(uploadTask).then((value) async {
                var newURL = await ref.getDownloadURL();
                databaseReference.child('image').set({
                  'id' : '1234s',
                  'title' : newURL.toString()
                }).then((value){
                  setState(() {
                    loading = false;
                  });
                  utils().toastMessage('Uploaded');
                }).onError((error, stackTrace){
                  setState(() {
                    loading = false;
                  });
                  utils().toastMessage(error.toString());
                });
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
