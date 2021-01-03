import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class PatientsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Our Patients'.text.sm.make(),
      ),
      body: ListView(
        children: [
          PatientTile(name: "Laure Shonen"),
          PatientTile(name: "Hiro Shonenka"),
          PatientTile(name: "Beatrice Hamada"),
          PatientTile(name: "Ashley Maria"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () {},
        tooltip: "Add a new patient",
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  final String name;

  const PatientTile({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(FontAwesomeIcons.user),
      ),
      title: name.text.make(),
      subtitle: Text.rich(
        TextSpan(
          text: "Birthday : Oct 21 1998 at Yaoundé",
          children: [
            TextSpan(text: "\nRegistered on Dec 12 2020\n"),
            TextSpan(text: "Last test taken on Jan 02 2021"),
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
    );
  }
}
