import 'package:compiled/domain/disease/disease-model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DiseaseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Disease.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            "Description".text.bold.make(),
            SizedBox(
              height: 10,
            ),
            Text(Disease.description),
            SizedBox(
              height: 20,
            ),
            "Caused by".text.bold.make(),
            SizedBox(
              height: 10,
            ),
            Text(Disease.causedBy),
            SizedBox(
              height: 20,
            ),
            "Causes".text.bold.make(),
            SizedBox(
              height: 10,
            ),
            Text(Disease.causes)
          ],
        ),
      ),
    );
  }
}
