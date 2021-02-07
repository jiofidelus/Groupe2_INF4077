import 'package:compiled/application/exports.dart';
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
        title: 'Victoire',
        theme: ThemeData(
          fontFamily: 'Avenir',
          primaryColor: HexColor.fromHex(""),
          accentColor: HexColor.fromHex(""),
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
}