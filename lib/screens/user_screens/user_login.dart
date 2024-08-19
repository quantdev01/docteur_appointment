import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_new/constants/constants.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_main.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_main.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;

      log(user.toString());

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          bool isDoctor = userDoc['isDoctor'];

          if (isDoctor == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DoctorMain()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserMain()),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      log('Error occured during SignIn $e');
    } catch (e) {
      log('Other error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Connectez-vous par Email / Mot de passe.',
                style: mediumText,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Mot de passe'),
                autocorrect: false,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                signIn(
                  _controllerEmail.text,
                  _controllerPassword.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UserMain()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                width: 220,
                child: const Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserRegister()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                width: 220,
                child: const Text(
                  "S'enregistrer",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
