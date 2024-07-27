import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_project/app_config.dart';
import 'package:startup_project/constant/bloc_provider.dart';
import 'package:startup_project/utils/preferences/local_perference.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:startup_project/utils/routes/routes.dart';

import 'constant/api_end_points.dart';
import 'utils/api_base_model/api_base_model.dart';

void main({String? env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageUtils.init();
  Bloc.observer = MyBlocObserver();
  final appConfig = await AppConfig().formEnviroment(env);

  runApp(
    MultiBlocProvider(
      providers: blocProvider,
      child: MyApp(appConfig: appConfig),
    ),
  );
}

late ApiEndPoints apiEndPoints;

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.appConfig,
  });

  final ApiBaseModel appConfig;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _goRouter = Routes();

  @override
  void initState() {
    super.initState();
    apiEndPoints = ApiEndPoints(apiBaseModel: widget.appConfig);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      child: MaterialApp.router(
        title: 'startup_project',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        //   pageTransitionsTheme: const PageTransitionsTheme(
        //     builders:
        //     {
        //       TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        //       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //     },
        //   ),
        // ),
        routeInformationParser: _goRouter.router.routeInformationParser,
        routerDelegate: _goRouter.router.routerDelegate,
        routeInformationProvider: _goRouter.router.routeInformationProvider,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
