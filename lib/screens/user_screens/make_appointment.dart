import 'package:flutter/material.dart';

class MakeAppointment extends StatefulWidget {
  const MakeAppointment({
    super.key,
    required doctorUid,
  });

  @override
  State<MakeAppointment> createState() => _MakeAppointmentState();
}

class _MakeAppointmentState extends State<MakeAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
    );
  }
}
