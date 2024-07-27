import 'package:go_router/go_router.dart';
import 'package:startup_project/presentations/get_data/get_data_screen.dart';
import 'package:startup_project/splash/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String getDataScreen = '/getData';

  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) =>
            LoginPage(), // Ensure you have the correct widget here
      ),
      GoRoute(
        path: getDataScreen,
        builder: (context, state) => GetDataScreen(),
      ),
    ],
  );
}
