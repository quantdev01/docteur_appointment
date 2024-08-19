import 'dart:developer';

import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:doctor_appointment_new/constants/constants.dart';
import 'package:doctor_appointment_new/screens/user_screens/goto_user.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSpeciality = TextEditingController();

  Future<void> signIn() async {
    try {
      await Auth().signUser(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      log('Error occured $e');
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> creatUser({
    required String name,
    required String email,
    required String password,
    required bool isDoctor,
    required String speciality,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'name': name,
            'email': email,
            'isDoctor': isDoctor,
            'createdAt': FieldValue.serverTimestamp(),
            'speciality': isDoctorChoice == 'Yes' ? speciality : '',
          },
        );
        if (isDoctor) {
          log('registered user $name successfully');
        } else {
          log('registered doctor $name successfully');
        }
      }
    } on FirebaseAuthException catch (e) {
      log('Error occured during registration $e');
    }
  }

  String? isDoctorChoice;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Enregistrez-vous',
                        style: mediumText,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Name'),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    controller: _controllerName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    controller: _controllerEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Password'),
                    autocorrect: false,
                    obscureText: true,
                    controller: _controllerPassword,
                  ),
                ),
                const Text('Are you a doctor?'),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Yes'),
                      Radio(
                        value: 'Yes',
                        groupValue: isDoctorChoice,
                        onChanged: (value) {
                          setState(() {
                            isDoctorChoice = value;
                          });
                        },
                      ),
                      const Text('No'),
                      Radio(
                        value: 'No',
                        groupValue: isDoctorChoice,
                        onChanged: (value) {
                          setState(() {
                            isDoctorChoice = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                isDoctorChoice == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          decoration:
                              const InputDecoration(hintText: 'Speciality'),
                          autocorrect: true,
                          controller: _controllerSpeciality,
                        ),
                      )
                    : const SizedBox(),
                GestureDetector(
                  onTap: () {
                    creatUser(
                      name: _controllerName.text,
                      email: _controllerEmail.text,
                      password: _controllerPassword.text,
                      isDoctor: isDoctorChoice == 'Yes' ? true : false,
                      speciality: _controllerSpeciality.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GotoUser()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                    ),
                    width: 220,
                    child: const Text(
                      "Je m'enregistre",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserLogin()),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
