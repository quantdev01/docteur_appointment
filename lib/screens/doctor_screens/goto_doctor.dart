import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_login.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_main.dart';
import 'package:flutter/material.dart';

class GotoDoctor extends StatefulWidget {
  const GotoDoctor({super.key});

  @override
  State<GotoDoctor> createState() => _GotoDoctorState();
}

class _GotoDoctorState extends State<GotoDoctor> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const DoctorMain();
          } else {
            return const DoctorLogin();
          }
        });
  }
}
