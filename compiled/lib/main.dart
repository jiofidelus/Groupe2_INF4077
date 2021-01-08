import 'package:compiled/application/exports.dart';
import 'package:compiled/application/locations/location_cubit.dart';
import 'package:compiled/presentation/auth/login_screen.dart';
import 'package:compiled/presentation/home/home_screen.dart';
import 'package:compiled/presentation/splash/splash_screen.dart';
import 'package:compiled/service-locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  startServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StartProviders(
      child: MaterialApp(
        title: 'EPI',
        theme: ThemeData(
          fontFamily: 'Avenir',
          primarySwatch: Colors.cyan,
          primaryColor: Colors.cyan[900],
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (BuildContext context) => getIt<AuthCubit>()),
        BlocProvider<PatientsCubit>(
            create: (BuildContext context) => getIt<PatientsCubit>()),
        BlocProvider<LocationCubit>(
            create: (BuildContext context) => getIt<LocationCubit>()),
      ],
      child: child,
    );
  }
}

class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        print(state);
        if (state.isRestoring) return SplashScreen();
        if (state.isLoggedIn) return HomeScreen();
        return LoginScreen();
      },
      buildWhen: (old, state) {
        return true;
        //print(old);
        //print(state);
        return (state.isRestoring != old.isRestoring);
      },
    );
  }
}
