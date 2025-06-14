import 'package:flutter/material.dart';

class NavigationService {
  factory NavigationService() => _instance;
  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
      String routeName, RoutePredicate predicate,
      {Object? arguments,}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }
  
  void pop([Object? result]) {
    navigatorKey.currentState!.pop(result);
  }
}
