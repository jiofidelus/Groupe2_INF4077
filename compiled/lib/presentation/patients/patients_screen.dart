import 'dart:io';

import 'package:compiled/application/exports.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:compiled/presentation/patients/new_patient_screen.dart';
import 'package:compiled/presentation/patients/patient_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../service-locator.dart';

class PatientsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Our Patients'.text.sm.make(),
      ),
      body:
          BlocBuilder<PatientsCubit, PatientsState>(builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator().centered();
        }
        if (state.patients != null && state.patients.isNotEmpty) {
          return ListView(
            children:
                state.patients.map((e) => PatientTile(patient: e)).toList(),
          );
        } else {
          return "Must not happen".text.makeCentered();
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider<GPSCubit>(
                  create: (context) => getIt<GPSCubit>()..getLocation(),
                  child: NewPatientScreen())));
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
    return BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
      return ListTile(
        leading: Hero(
          tag: "photo${patient.id}",
          child: CircleAvatar(
            child: patient.picture.startsWith('http')
                ? Image.network(
                    patient.picture,
                  )
                : patient.picture.isNotEmpty
                    ? Image.file(
                        File(patient.picture),
                        fit: BoxFit.cover,
                      )
                    : Icon(FontAwesomeIcons.user),
          ),
        ),
        title: Hero(tag: "name${patient.id}", child: patient.name.text.make()),
        subtitle: Text.rich(
          TextSpan(
            text:
                "Born on : ${patient.cleanBirthday} at ${state.locations != null ? state.locations.firstWhere((element) => element.id == patient.birthCity).name : ""}",
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
    });
  }
}
