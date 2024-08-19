import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:doctor_appointment_new/screens/user_screens/make_appointment.dart';
import 'package:doctor_appointment_new/screens/user_screens/user_login.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  const UserMain({
    super.key,
  });

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  final user = Auth().currenUser;
  Future<void> bookAppointment(
      String userId, String doctorId, String date, String time) async {
    await FirebaseFirestore.instance.collection('appointments').add({
      'userId': userId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
      // Add any other fields as necessary
    });
  }

  final data = {
    'name': 'Jeanne D\'Arc',
    'email': 'jeanne@gmail.com',
    'speciality': 'Pediatre',
  };
  final Timestamp timePicked = Timestamp(0, 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User'),
          actions: [
            GestureDetector(
              onTap: () {
                Auth().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLogin(),
                  ),
                );
              },
              child: const Icon(
                Icons.logout_outlined,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isDoctor', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var doctors = snapshot.data!.docs;

            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                var doctor = doctors[index].data();
                return ListTile(
                  title: Text(doctor['name']),
                  subtitle: Text(doctor['speciality']),
                  onTap: () {
                    // * Implementing the appointment with doctor
                    final doctorUid = doctor['name'].uid;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeAppointment(
                                doctorUid: doctorUid,
                              )),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
