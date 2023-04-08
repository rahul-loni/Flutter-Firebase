import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading = false;

  //pick Image from  gallery Method
  File? _image;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked ");
      }
    });
  }

//Upload Image in firebase

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DatabaseReference database = FirebaseDatabase.instance.ref('post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Image"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    getGalleryImage();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Colors.pink,
                      ),
                    ),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(
                            child: Icon(Icons.image),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedButton(
                  title: 'Upload Image',
                  onTap: () async {
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/foldername' + '1224');
                    firebase_storage.UploadTask uploadTask =
                        ref.putFile(_image!.absolute);

                    await Future.value(uploadTask);
                    var newUrl = ref.getDownloadURL();

                    database
                        .child('1')
                        .set({'id': '1221', 'title': newUrl.toString()});
                    Utils().toastMessage("Image Uploaded");
                  },
                  loading: loading)
            ],
          ),
        ));
  }
}
