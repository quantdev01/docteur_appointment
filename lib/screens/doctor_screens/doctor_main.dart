import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_new/backend/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorMain extends StatefulWidget {
  const DoctorMain({super.key});

  @override
  State<DoctorMain> createState() => _DoctorMainState();
}

class _DoctorMainState extends State<DoctorMain> {
  final user = Auth().currenUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where(
              'doctorId',
              isEqualTo: user!.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          var appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index].data();
              return ListTile(
                title: Text('Appointment with ${appointment['userName']}'),
                subtitle:
                    Text('On ${appointment['date']} at ${appointment['time']}'),
              );
            },
          );
        },
      ),
    );
  }
}
