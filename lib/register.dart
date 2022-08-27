import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/landing_screen.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 252, 251, 251)),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LandingScreen())),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text("Register User",
              style: TextStyle(
                  color: Color.fromARGB(255, 244, 152, 32),
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Type in your Email',
                  filled: true,
                  fillColor: const Color(0xffFDF6F6),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              controller: emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 40.0),
            child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Create a Password",
                    filled: true,
                    fillColor: const Color(0xffFDF6F6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                controller: passwordController),
          ),
          Center(
            child: SizedBox(
              width: 225,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: const [
                    Icon(
                      Icons.app_registration_rounded,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: googleText,
                    ),
                  ],
                ),
                onPressed: () {
                  // Handle sign in
                  auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim())
                      .then((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LandingScreen()));
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
