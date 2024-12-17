import 'package:clean_arch/presenter/ui/dashboard/dashboard_page.dart';
import 'package:clean_arch/presenter/ui/login/login_page.dart';
import 'package:clean_arch/presenter/ui/signup/signup_page.dart';
import 'package:flutter/material.dart';

class Routes {
  // Named routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';

  // Define all routes in the application in one place
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      default:
        return _errorRoute();
    }
  }

  // A method to define the error route when a route is not found
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }

  // Method for navigating to a named route
  static void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  // Method for navigating to a route and removing all previous routes from the stack
  static void navigateAndRemoveAll(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
    );
  }
}
