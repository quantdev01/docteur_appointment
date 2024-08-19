import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_login.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_register.dart';
import 'package:flutter/material.dart';

class GotoUser extends StatefulWidget {
  const GotoUser({super.key});

  @override
  State<GotoUser> createState() => _GotoUserState();
}

class _GotoUserState extends State<GotoUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const UserLogin();
          } else {
            return const UserRegister();
          }
        });
  }
}
