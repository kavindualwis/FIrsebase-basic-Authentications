// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'package:fire_auth_01/components/my_button.dart';
import 'package:fire_auth_01/components/my_text_field.dart';
import 'package:fire_auth_01/components/square_tile.dart';
import 'package:fire_auth_01/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //User Sign In method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign up
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }
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
            title: const Text('Register Failed'),
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
                    size: 50,
                  ),

                  const SizedBox(height: 50),

                  //Welcome Back msg
                  Text(
                    'Let\'s create an account for you!',
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

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obsureText: true,
                  ),

                  const SizedBox(height: 10),

                  //forgot pasw

                  const SizedBox(height: 10),

                  //sign in buttons

                  MyButton(
                    onTap: signUserUp,
                    buttonName: 'Sign Up',
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
                        onTap: () => () {},
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
                        const Text('Already have an account'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login',
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
