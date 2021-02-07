import 'dart:io';

import 'package:compiled/application/exports.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/infrastructure/exports.dart';
import 'package:compiled/presentation/patients/new_patient_screen.dart';
import 'package:compiled/presentation/patients/patient_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../service-locator.dart';

class PatientsListScreen extends StatefulWidget {
  @override
  _PatientsListScreenState createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> {
  var loading = true;
  List<Patient> patients;
  Map<String, dynamic> error = {};
  List<dynamic> result = [];

  loadPatients() async {
    Response response = await NetworkManager.I.get("/patients");
    print(response.data);
    print(response.headers);
    print(response.request);
    print(response.statusCode);
    loading = false;

    if (response.statusCode > 299) {
      error = response.data;
    } else {
      result = response.data;
    }
    setState(() {});
  }

  @override
  void initState() {
    loadPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Our Patients'.text.sm.make(),
      ),
      body: Builder(builder: (BuildContext context) {
        if (loading) {
          return CircularProgressIndicator().centered();
        }
        if (result != null && result.isNotEmpty) {
          return ListView(
            children: result.map((e) {
              var p = Patient.fromMap(e);
              print(p.id);
              return PatientTile(patient: p);
            }).toList(),
          );
        } else {
          return "Must not happen".text.makeCentered();
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewPatientScreen()));
        },
        tooltip: "Add a new patient",
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  final Patient patient;

  const PatientTile({Key key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: "photo${patient.id}",
        child: CircleAvatar(
          child: Icon(FontAwesomeIcons.user),
        ),
      ),
      title: Hero(tag: "name${patient.id}", child: patient.name.text.make()),
      subtitle: Text.rich(
        TextSpan(
          text: "Located at Yaoundé",
          children: [
            TextSpan(text: "\nRegistered on ${patient.cleanCreatedOn}\n"),
            TextSpan(text: "Phone: ${patient.phone}"),
          ],
        ),
        style: TextStyle(fontSize: 12),
      ),
      isThreeLine: true,
      trailing: IconButton(
        icon: Icon(FontAwesomeIcons.stethoscope),
        onPressed: () {},
        tooltip: "Consult this user",
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PatientDetailScreen(patient: patient)));
      },
    );
  }
}
