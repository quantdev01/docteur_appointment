import 'package:doctor_appointment_new/constants/constants.dart';
import 'package:flutter/material.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
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
                'Connectez-vous : \nEmail / Mot de passe.',
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
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {},
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
