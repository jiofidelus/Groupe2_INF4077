import 'package:compiled/domain/disease/disease-model.dart';
import 'package:compiled/presentation/disease/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class SymptomCheckerScreen extends StatefulWidget {
  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  int index = 0;
  int max = Symptom.all.length;
  int points = 0;

  isYes(BuildContext context) {
    points += Symptom.all[index].points;
    if (index == max - 1)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckerResultScreen(points: points)));
    else
      setState(() {
        index++;
      });
  }

  isNo() {
    if (index == max - 1)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckerResultScreen(points: points)));
    else
      setState(() {
        index++;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Consultation".text.make(),
        ),
        body: ListView(
          children: [
            Card(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${index + 1}/$max".text.sm.gray700.make(),
                    SizedBox(
                      height: 8,
                    ),
                    Symptom.all[index].name.text.bold.xl2.makeCentered(),
                    SizedBox(
                      height: 16,
                    ),
                    Symptom.all[index].question.text.makeCentered(),
                    SizedBox(
                      height: 24,
                    ),
                    if (index < max)
                      OutlineButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          setState(() {
                            isYes(context);
                          });
                        },
                        child: "Yes".text.make(),
                      ).wFull(context).px8(),
                    if (index < max)
                      SizedBox(
                        height: 4,
                      ),
                    if (index < max)
                      OutlineButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          setState(() {
                            isNo();
                          });
                        },
                        child: "No".text.make(),
                      ).wFull(context).px8(),
                    if (index >= max)
                      FlatButton(
                        color: context.primaryColor,
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CheckerResultScreen()));
                        },
                        child: "Stop and get results".text.make(),
                      ).wFull(context).px8(),
                  ],
                ).p4(),
              ),
            ).p8(),
            Card(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  "Information".text.bold.make(),
                  SizedBox(height: 16),
                  "No available description for this symptom".text.make(),
                  SizedBox(height: 8),
                ],
              ).p8(),
            ).p8(),
            Card(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  "Live recording".text.bold.make(),
                  SizedBox(height: 16),
                  "Press the button below to record the current consultation session"
                      .text
                      .make(),
                  SizedBox(height: 8),
                  IconButton(
                    color: Vx.red500,
                    iconSize: 32,
                    icon: Icon(FontAwesomeIcons.microphone),
                    tooltip: "Start recording",
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: 'Recording started'.text.make()));
                    },
                  ),
                  IconButton(
                    color: Vx.red500,
                    iconSize: 32,
                    tooltip: "Stop recording",
                    icon: Icon(FontAwesomeIcons.stop),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: 'Recording started'.text.make()));
                    },
                  ),
                ],
              ).p16(),
            ).p8()
          ],
        ).wFull(context));
  }
}
