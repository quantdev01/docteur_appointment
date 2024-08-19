import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:doctor_appointment_new/constants/constants.dart';
import 'package:doctor_appointment_new/firebase_options.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_login.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_main.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/doctor_register.dart';
import 'package:doctor_appointment_new/screens/doctor_screens/goto_doctor.dart';
import 'package:doctor_appointment_new/screens/user_screens/goto_user.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_login.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_main.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  runApp(
    const HomePageSecond(),
  );
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currenUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/user_login': (BuildContext context) => const UserLogin(),
        '/user_register': (BuildContext context) => const UserRegister(),
        '/user_main': (BuildContext context) => const UserMain(),
        '/doctor_login': (BuildContext context) => const DoctorLogin(),
        '/doctor_register': (BuildContext context) => const DoctorRegister(),
        '/doctor_main': (BuildContext context) => const DoctorMain(),
        '/home_page': (BuildContext context) => HomePage(),
        '/goto_doctor': (BuildContext context) => const GotoDoctor(),
        '/goto_user': (BuildContext context) => const GotoUser(),
      },
      debugShowCheckedModeBanner: false,
      home: const HomePageSecond(),
    );
  }
}

class HomePageSecond extends StatelessWidget {
  const HomePageSecond({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Prenez rendez-vous ici.",
                    style: largeFontText,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/user_register');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserRegister()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                    ),
                    width: 220,
                    child: const Text(
                      "Je prend rendez-vous",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
