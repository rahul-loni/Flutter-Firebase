import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widget/rounded_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Post Screen",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is your Mind ?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            RoundedButton(
              title: "Click Me ",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                databaseRef
                    .child(
                  DateTime.now().microsecondsSinceEpoch.toString(),
                )
                    // .child('Comments')
                    .set({
                  'title': postController.text.toString(),
                  'id': DateTime.now().microsecondsSinceEpoch.toString(),
                }).then((value) {
                  Utils().toastMessage("Post Added");
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = true;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
