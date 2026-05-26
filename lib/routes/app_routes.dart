import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/dzikir_page.dart';
import '../pages/doa_page.dart';
import '../pages/trend_page.dart';

class AppRoutes {
  static const String home = "/";
  static const String dzikir = "/dzikir";
  static const String doa = "/doa";
  static const trend = "/trend";

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),

    dzikir: (context) => const DzikirPage(),

    doa: (context) => const DoaPage(),

    trend: (context) => const TrendPage(),
  };
}
