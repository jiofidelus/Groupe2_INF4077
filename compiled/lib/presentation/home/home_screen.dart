import 'package:compiled/application/auth/auth_cubit.dart';
import 'package:compiled/application/exports.dart';
import 'package:compiled/presentation/disease/disease_info_screen.dart';
import 'package:compiled/presentation/disease/symptom_checker_screen.dart';
import 'package:compiled/presentation/disease/symptom_screen.dart';
import 'package:compiled/presentation/patients/patients_screen.dart';
import 'package:compiled/presentation/statistics/chart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Victoire'),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
              ),
              ListTile(
                title: Text("Disease"),
                leading: Icon(FontAwesomeIcons.disease).iconColor(Vx.red400),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text("Symptoms"),
                leading: Icon(FontAwesomeIcons.viruses).iconColor(Vx.green400),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text("Precautions"),
                leading: Icon(FontAwesomeIcons.firstAid).iconColor(Vx.red500),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(FontAwesomeIcons.powerOff),
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: "Yaoundé, Cameroun".text.sm.center.make(),
          actions: [
            IconButton(icon: Icon(FontAwesomeIcons.bell), onPressed: null)
                .scale75()
          ],
        ),
        body: Stack(
          overflow: Overflow.visible,
          fit: StackFit.expand,
          children: [
            Widget1(),
            Widget2Container().hFull(context).positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                ),
          ],
        ));
  }
}

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Icon(
              FontAwesomeIcons.virus,
              color: Colors.purple[400],
              size: 150,
            ).opacity75(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              "Victoire".text.xl4.bold.center.make(),
              "Version 1.0.0".text.make(),
            ],
          ).py8().px16(),
        ],
      ),
    ).backgroundColor(context.primaryColor).h24(context);
  }
}

class Widget2Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 40),
        child: Widget2Content(),
      ).backgroundColor(Vx.white),
    );
  }
}

class Widget2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SymptomCheckerCard(),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*   HomeMenuButton(
              name: "Map",
              icon: FontAwesomeIcons.globeAfrica,
            ),*/
            Expanded(
              child: HomeMenuButton(
                name: "Symptom",
                icon: FontAwesomeIcons.bacteria,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SymptomScreen()));
                },
              ),
            ),
            /*  HomeMenuButton(
              name: "Contact",
              icon: FontAwesomeIcons.addressCard,
            ),*/
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeMenuButton(
              name: "Statistics",
              icon: FontAwesomeIcons.chartPie,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ChartScreen.withSampleData();
                }));
              },
            ),
            HomeMenuButton(
              name: "Patients",
              icon: FontAwesomeIcons.personBooth,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientsListScreen()));
              },
            ),
            HomeMenuButton(
              name: "Details",
              icon: FontAwesomeIcons.info,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DiseaseInfo()));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SymptomCheckerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    "Symptom checker".text.bold.xl2.make(),
                    "Based on common symptoms".text.sm.make(),
                  ]).py32().px8()
                ],
              ),
            ),
          )
              .onInkTap(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SymptomCheckerScreen()));
              })
              .material()
              .card
              .make(),
          Positioned(
              bottom: -6,
              child: IgnorePointer(
                  child: Image(
                image: AssetImage("assets/img/screening.png"),
                height: 100,
              ).px8())),
        ],
      ),
    );
  }
}

class HomeMenuButton extends StatelessWidget {
  final String name;
  final String image;
  final IconData icon;
  final void Function() onTap;

  const HomeMenuButton({
    Key key,
    this.name = "No name",
    this.image = "assets/img/login_logo.png",
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: icon != null
              ? new Icon(
                  icon,
                  size: 60,
                  color: context.primaryColor,
                ).h(60).px16().py8()
              : new Image(
                      height: 60,
                      fit: BoxFit.fill,
                      image: new AssetImage(image))
                  .p8(),
        ).onInkTap(onTap).card.make(),
        name.text.sm.makeCentered()
      ],
    );
  }
}