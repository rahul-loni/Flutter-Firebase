import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/home_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widget/rounded_button.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Code "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: " Enter 6 digit code",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              title: 'Verify',
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: phoneNumberController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(
                    e.toString(),
                  );
                }
              },
              loading: loading,
            ),
          ],
        ),
      ),
    );
  }
}
