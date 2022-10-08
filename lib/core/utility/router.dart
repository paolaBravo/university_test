import 'package:get/get.dart';
import 'package:university_test/features/presentation/pages/home_page.dart';
import 'package:university_test/features/presentation/pages/login_page.dart';
import 'package:university_test/features/presentation/pages/sign_up_page.dart';
import 'package:university_test/features/presentation/pages/universities_page.dart';

class Router {
  static final routes = [
    GetPage(
      name: '/universities',
      page: () => UniversitiesPage(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/signUp',
      page: () => SignUpPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
  ];
}
