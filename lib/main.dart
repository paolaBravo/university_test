import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:university_test/core/utility/theme.dart';
import 'package:university_test/dependency_injection/injector.dart';

import 'core/utility/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  Injector.setup();
  String initialPage() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      return "/universities";
    } else {
      return "/home";
    }
  }

  runApp(
    GetMaterialApp(
      title: 'University app',
      theme: Themes().theme,
      debugShowCheckedModeBanner: false,
      getPages: Router.routes,
      initialRoute: initialPage(),
    ),
  );
}
