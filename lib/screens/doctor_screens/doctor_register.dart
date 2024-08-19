import 'package:doctor_appointment_new/constants/constants.dart';
import 'package:flutter/material.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
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
                'Enregistrez vous avec une email et un mot de passe.',
                style: mediumText,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
              ),
            ),
            GestureDetector(
              onTap: () {},
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
                Navigator.of(context).pushNamed('/doctor_login');
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
      ),
    );
  }
}
