
import 'package:go_router/go_router.dart';
import 'package:startup_project/splash/splash_screen.dart';


class Routes {
  static const String splashScreen = '/';

  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) =>  LoginPage(),
      ),
    ],
  );
}
