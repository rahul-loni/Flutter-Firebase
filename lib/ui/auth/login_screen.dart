import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/forgot_password_screen.dart';
import 'package:firebase_flutter/ui/auth/login_with_phone_number.dart';
import 'package:firebase_flutter/ui/auth/signup_screen.dart';
import 'package:firebase_flutter/ui/home_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widget/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      setState(() {
        loading = true;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/loginn.png',
                    width: 200,
                    height: 160,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailController,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      helperText: 'Enter email e.g: rahul@gmail.com',
                      helperStyle: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      hintText: 'Enter Email',
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              title: 'Sign In',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              // child: InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const ForgotPasswordScreen(),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     "Forgot Password",
              //     style: TextStyle(
              //       fontSize: 22,
              //       color: Colors.red,
              //     ),
              //   ),
              // ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginWithPhoneNumber(),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.amber)),
                child: Center(
                  child: Text("Login with Phone Number "),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
