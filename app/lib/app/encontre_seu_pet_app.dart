import 'package:app/blocs/application/application_bloc.dart';
import 'package:app/blocs/application/application_event.dart';
import 'package:app/blocs/application/application_state.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/splash/splash_screen.dart';
import 'package:catcher/core/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EncontreSeuPet extends StatefulWidget {
  @override
  _EncontreSeuPetState createState() => _EncontreSeuPetState();
}

class _EncontreSeuPetState extends State<EncontreSeuPet> {
  ApplicationBloc _appBloc;
  @override
  void initState() {
    super.initState();
    _appBloc = ApplicationBloc();
    _appBloc.add(ApplicationStartEvent());
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
            builder: (BuildContext context) => _appBloc),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Catcher.navigatorKey,
        title: "Encontre Seu Pet",
        supportedLocales : [
          const  Locale ('pt'),
        ],
        home: BlocBuilder<ApplicationBloc, ApplicationState>(
          builder: (context, state) {
            if (state.isInitializing) {
              return SplashScreen();
            }

            if (!state.isAuthenticated) {
              return LoginScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
