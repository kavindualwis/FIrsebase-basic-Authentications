// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'package:fire_auth_01/components/my_button.dart';
import 'package:fire_auth_01/components/my_text_field.dart';
import 'package:fire_auth_01/components/square_tile.dart';
import 'package:fire_auth_01/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //User Sign In method
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        );
      },
    );

    //try sign in
    try {
      //try sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //show alert dialog with error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign in Failed'),
            content: const Text('Username Or Password Incorrect'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: GestureDetector(
        onTap: () {
          // When tapped outside of text fields, unfocus them
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  //logo

                  const Icon(
                    Icons.chat,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  //Welcome Back msg

                  Text(
                    'Welcome Back You',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //email field

                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obsureText: false,
                  ),

                  const SizedBox(height: 10),

                  //password

                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obsureText: true,
                  ),

                  const SizedBox(height: 10),

                  //forgot pasw

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  //sign in buttons

                  MyButton(
                    onTap: signUserIn,
                    buttonName: 'Sign In',
                  ),

                  const SizedBox(height: 50),
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 0.8,
                          ),
                        ),
                        const Text(
                          'Or Continue With',
                          style: TextStyle(color: Colors.black),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  //google + apple sign in buttons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google button
                      SquareTile(
                        imagePath: 'images/googlelogo.png',
                        onTap: () => Authservice().signInWithGoogle(),
                      ),

                      const SizedBox(width: 10),

                      //Apple button
                      SquareTile(
                        imagePath: 'images/applelogo.png',
                        onTap: () {},
                      ),
                    ],
                  ),
                  //Not a member,gerister now

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not a member?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
