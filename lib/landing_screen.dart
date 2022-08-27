import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/home_screen.dart';
import 'package:firechat/loading.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print("Firebase User: ${FirebaseAuth.instance.currentUser}");

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          } else if (snapshot.hasData) {
            // Home (chats) screen
            print('home screen');
            return const HomeScreen();
          } else {
            // Login component
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 20.0),
                    child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: const Color(0xffFDF6F6),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        controller: emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 60.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: const Color(0xffFDF6F6),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      controller: passwordController,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 225,
                      height: 50,
                      child: ElevatedButton(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.login,
                              size: 30.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              style: googleText,
                            ),
                          ],
                        ),
                        onPressed: () {
                          // Handle sign in
                          auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim())
                              .then((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
