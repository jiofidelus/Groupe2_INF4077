import 'dart:io';

import 'package:compiled/application/exports.dart';
import 'package:compiled/domain/model_export.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class NewPatientScreen extends StatefulWidget {
  @override
  _NewPatientScreenState createState() => _NewPatientScreenState();
}

class _NewPatientScreenState extends State<NewPatientScreen> {
  final picker = ImagePicker();

  String name;

  String email;

  String picture;

  String phone;

  DateTime birthday;

  int birthCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "New user".text.make(),
        actions: [
          FlatButton.icon(
              onPressed: () {
                var p = Patient.create(
                    name: name,
                    phone: phone,
                    birthday: birthday,
                    email: email,
                    birthCity: birthCity,
                    picture: picture);
                BlocProvider.of<PatientsCubit>(context).createPatient(p);
              },
              icon: Icon(FontAwesomeIcons.save),
              label: "Save".text.make())
        ],
      ),
      body: BlocListener<PatientsCubit, PatientsState>(
        listener: (context, state) {
          if (!state.isLoading) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<PatientsCubit, PatientsState>(
            builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(),
                      bottom: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide(),
                    )),
                    child: picture != null
                        ? Image(
                            image: FileImage(File(picture)),
                          )
                        : Center(
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.camera),
                                  iconSize: 32,
                                  color: Vx.gray700,
                                  onPressed: () async {
                                    final pickedFile = await picker.getImage(
                                        source: ImageSource.camera);
                                    picture = pickedFile.path;
                                    setState(() {});
                                  },
                                ),
                                "Take a picture".text.make(),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 16),
                  "User Information".text.semiBold.gray700.make().py4(),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "The patients full name",
                        isDense: true,
                        labelText: "Full name",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        )),
                    onChanged: (val) {
                      name = val;
                    },
                  ).py4(),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "The patient's email address",
                        isDense: true,
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        )),
                    onChanged: (val) {
                      email = val;
                    },
                  ).py4(),
                  TextField(
                    keyboardType: TextInputType.phone,
                    onChanged: (val) {
                      phone = val;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "The patient's phone number",
                        isDense: true,
                        labelText: "Phone number",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        )),
                  ).py4(),
                  DateTimePicker(
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "The patient's birthday",
                        isDense: true,
                        labelText: "Date of birth",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        )),
                    initialValue: '',
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Date',
                    onChanged: (val) {
                      birthday = DateTime.tryParse(val);
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ).py4(),
                  BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                    print(state.locations);
                    if (state.locations == null)
                      return CircularProgressIndicator();
                    return SelectFormField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.caretDown),
                          filled: true,
                          hintText: "The patient's birth region",
                          isDense: true,
                          labelText: "Birth location",
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          )),
                      type: SelectFormFieldType.dialog, // or can be dialog
                      initialValue: 'circle',
                      icon: Icon(Icons.format_shapes),
                      labelText: 'Region of birth',
                      items: state.locations
                          .map((e) =>
                              {"value": e.id.toString(), "label": e.name})
                          .toList(),
                      onChanged: (val) {
                        birthCity = int.tryParse(val);
                      },
                      onSaved: (val) => print(val),
                    ).py4();
                  }),
                  SizedBox(height: 16),
                  "User Position".text.semiBold.gray700.make().py4(),
                  BlocBuilder<GPSCubit, GPSState>(
                      builder: (context, state) => ListView(
                            shrinkWrap: true,
                            children: [
                              if (state.failed)
                                (state.errorTitle +
                                        ' : ' +
                                        state.errorDescription)
                                    .text
                                    .sm
                                    .red800
                                    .make(),
                              ListTile(
                                title: "Longitude".text.make(),
                                subtitle: Text(state.isLoading
                                    ? "Loading"
                                    : "${state.longitude}"),
                              ),
                              ListTile(
                                title: "Longitude".text.make(),
                                subtitle: Text(state.isLoading
                                    ? "Loading"
                                    : "${state.latitude}"),
                              ),
                              ListTile(
                                title: "Current Location".text.make(),
                                subtitle: Text(state.isLoading
                                    ? "Loading"
                                    : "${state.location.name}"),
                              ),
                            ],
                          )),
                ],
              ),
              if (state.isLoading)
                Positioned.fill(
                    child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
            ],
          );
        }),
      ),
    );
  }
}
