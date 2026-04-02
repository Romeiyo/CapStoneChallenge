import 'package:flutter/material.dart';
import 'package:geo_weather_logger_app/presentation/screens/auth_gate.dart';
import 'package:geo_weather_logger_app/presentation/screens/homepage.dart';
import 'package:geo_weather_logger_app/presentation/screens/login_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NoArgs {
  const NoArgs();
}

enum AppRoute<T> {
  homepage<NoArgs>(),
  login<NoArgs>(),
  authGate<NoArgs>();

  const AppRoute();

  Route<dynamic> route(T args) {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => switch (this) {
        AppRoute.authGate => const AuthGate(),
        AppRoute.homepage => const Homepage(),
        AppRoute.login => const LoginScreen(),
      },
    );
  }
}

extension AppNavigator on NavigatorState {
  Future<R?> pushRoute<R>(AppRoute<NoArgs> route) {
    return push(route.route(const NoArgs())).then((result) => result as R?);
  }

  Future<void> pushRouteAndRemoveUntil<R>(AppRoute<NoArgs> route) {
    final navigator = this;
    return navigator.pushAndRemoveUntil(
      route.route(const NoArgs()),
      (r) => false,
    );
  }
}

extension AppNavigatorContext on BuildContext {
  Future<R?> pushRoute<R>(AppRoute<NoArgs> route) {
    return Navigator.of(
      this,
    ).push(route.route(const NoArgs())).then((result) => result as R?);
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future<void> pushRouteAndRemoveUntil<R>(AppRoute<NoArgs> route) {
    return Navigator.of(
      this,
    ).pushAndRemoveUntil(route.route(const NoArgs()), (route) => false);
  }
}
