import 'package:compiled/domain/disease/disease-model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SymptomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Disease.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            "Symptoms".text.bold.make(),
            SizedBox(
              height: 10,
            ),
            ...Symptom.all.map((e) => ListTile(
                  title: e.name.text.make(),
                  subtitle: e.information.text.make(),
                ))
          ],
        ),
      ),
    );
  }
}
