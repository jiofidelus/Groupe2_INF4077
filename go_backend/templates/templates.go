package templates

// Home page
const Home = `import 'package:compiled/application/auth/auth_cubit.dart';
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
                child: Text('{{.App.Name}}'),
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
              "{{.App.Name}}".text.xl4.bold.center.make(),
              "Version {{.App.Version}}".text.make(),
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
}`

// Yaml comment
const Yaml = `name: compiled
description: A new Flutter project.


# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
version: {{.App.Version}}

environment:
  sdk: ">=2.7.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^6.0.0
  dio: ^3.0.10
  get_it: ^5.0.3
  equatable: ^1.2.5
  font_awesome_flutter: ^8.11.0
  shared_preferences: ^0.5.12+4
  charts_flutter: ^0.9.0
  dartz: ^0.9.2
  velocity_x: ^1.3.1
  cool_alert: ^1.0.3
  flutter_easyloading: ^2.2.2
  intl: ^0.16.1
  flutter_sound: ^7.4.14+1
  date_time_picker: ^1.1.1
  select_form_field: "^1.1.0"
  geolocator: ^6.1.13
  image_picker: ^0.6.7+17
  mapbox_search: ^2.0.1+1


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  assets:
    - assets/img/
    - assets/mocks/

  fonts:
    - family: Avenir
      fonts:
        - asset: assets/fonts/Avenir/AvenirLTStd-Book.otf
          style: normal
        - asset: assets/fonts/Avenir/AvenirLTStd-Roman.otf
          weight: 700
        - asset: assets/fonts/Avenir/AvenirLTStd-Black.otf
          weight: 900
    - family: WorkSansSemiBold
      fonts:
        - asset: assets/fonts/Work_Sans/WorkSans-SemiBold.ttf

    - family: WorkSansBold
      fonts:
        - asset: assets/fonts/Work_Sans/WorkSans-Bold.ttf

    - family: WorkSansMedium
      fonts:
          - asset: assets/fonts/Work_Sans/WorkSans-Medium.ttf

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages
`

// Regions comment
const Regions = `import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HLocation extends Equatable {
  static const List<HLocation> regions = [
  {{range .Regions}}
    HLocation(name: "{{.Name}}", code: "{{.Code}}", id: {{.ID}}),
  {{end}}

  ];

  final String name;
  final String code;
  final int id;
  final double lat;
  final double long;

  const HLocation(
      {@required this.name,
      @required this.code,
      @required this.id,
      this.lat,
      this.long});

  factory HLocation.fromMap(Map<String, dynamic> map) {
    return new HLocation(
      name: map['name'] as String,
      code: map['code'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'code': this.code,
      'id': this.id,
      'lat': this.lat,
      'long': this.long,
    } as Map<String, dynamic>;
  }


  @override
  List<Object> get props => [name, code, id, lat, long];
}`

// Disease comment
const Disease = `import 'package:meta/meta.dart';

class Disease {
  static const String name = "{{.Disease.Name}}";
  static const String causedBy ="{{.Disease.CausedBy}}";
  static const String description = "{{.Disease.Description}}";
  static const String causes = "{{.Disease.Causes}}";
}

class Symptom {
  final String name;
  final int points;
  final String information;
  final String question;

  const Symptom._(
      {@required this.name,
      @required this.points,
      @required this.information,
      @required this.question});

  static const List<Symptom> all = [
  {{range .Symptoms}}
    Symptom._(name: "{{.Name}}", points: {{.Points}}, information: "{{.Information}}", question: "{{.Question}}"),
  {{end}}
  ];
}

class Result {
  final int start;
  final int end;
  final String overview;
  final String description;
  final List<String> advices;

  const Result._({
    @required this.start,
    @required this.end,
    @required this.overview,
    @required this.description,
    @required this.advices,
  });

  static const List<Result> all = [
   {{range .Results}}
    Result._(
           start: {{.Start}},
           end: {{.End}},
           overview: "{{.Overview}}",
           description: "{{.Description}}",
           advices: [
              {{range .Advices}}
              "{{.}}",
              {{end}}
           ],
    ),
    {{end}}

  ];
}`

// MainApp comment
const MainApp = `import 'package:compiled/application/exports.dart';
import 'package:compiled/application/locations/location_cubit.dart';
import 'package:compiled/presentation/auth/login_screen.dart';
import 'package:compiled/presentation/home/home_screen.dart';
import 'package:compiled/presentation/splash/splash_screen.dart';
import 'package:compiled/service-locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'infrastructure/network-manager/network-manager.dart';

void main() {
  //startServiceLocator();
NetworkManager.init();
  runApp(MyApp());
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }


  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StartProviders(
      child: MaterialApp(
        title: '{{.App.Name}}',
        theme: ThemeData(
          fontFamily: 'Avenir',
          primaryColor: HexColor.fromHex("{{.App.PrimaryColor}}"),
          accentColor: HexColor.fromHex("{{.App.AccentColor}}"),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: EasyLoading.init(),
        home: AppStart(),
      ),
    );
  }
}

class StartProviders extends StatelessWidget {
  final dynamic child;

  const StartProviders({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AppStart extends StatefulWidget {
  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  bool isRestoring = true;
  bool isLoggedIn = false;

  showSplash() async {
    print("Splash function");
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isRestoring = false;
    });
  }

  doLogin() {
    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  void initState() {
    showSplash();
  }

  @override
  Widget build(BuildContext context) {
    if (isRestoring) return SplashScreen();
    if (isLoggedIn) return HomeScreen();
    return LoginScreen(onLogin: doLogin);
    ;
  }
}`
