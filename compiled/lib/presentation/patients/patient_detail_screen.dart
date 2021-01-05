import 'dart:io';

import 'package:compiled/application/exports.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  PatientDetailScreen({@required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(FontAwesomeIcons.stethoscope), tooltip: "Consult ${patient.name}", onPressed: (){},),
      appBar: AppBar(
        title: Row(
          children: [
            Hero(tag: "photo${patient.id}", child: CircleAvatar(
              child: patient.picture.startsWith('http')
                  ? Image.network(patient.picture)
                  : patient.picture.isNotEmpty
                  ? Image.file(File(patient.picture))
                  : Icon(FontAwesomeIcons.user),
              radius: 20,
            ),),
            SizedBox(width: 10,),
            Hero(tag: "name${patient.id}", child: patient.name.text.sm.make()),

          ],
        ),
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          var birthplace = state.locations.firstWhere((element) => element.id== patient.birthCity).name;
          var currentCity = state.locations.firstWhere((element) => element.id== patient.createdAt).name;
          return ListView(
            children: [
              "Personal Info".text.bold.size(21).make().p4(),
              SizedBox(height: 4,),
              ListTile(title: "Birthday".text.make(), subtitle: patient.cleanBirthday.text.make(),),
              ListTile(title: "Birth Place".text.make(), subtitle:birthplace.text.make(),),
              ListTile(title: "Registerd on".text.make(), subtitle: patient.cleanCreatedOn.text.make(),),
              ListTile(title: "Current city".text.make(), subtitle: currentCity.text.make(),)
            ],
          );
        },
      ),
    );
  }
}
