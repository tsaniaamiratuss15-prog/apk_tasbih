import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/dzikir_page.dart';
import '../pages/doa_page.dart';
import '../pages/trend_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const String home = "/home";
  static const String dzikir = "/dzikir";
  static const String doa = "/doa";
  static const String trend = "/trend";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomePage(),
    dzikir: (context) => const DzikirPage(),
    doa: (context) => const DoaPage(),
    trend: (context) => const TrendPage(),
  };
}
