// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import "package:device_preview/device_preview.dart";
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skinspy/project/HomePage.dart';
import 'package:skinspy/project/Profile.dart';
import 'package:skinspy/project/result.dart';
import 'package:skinspy/project/scan.dart';
import 'package:skinspy/project/scaning.dart';
import 'firebase_options.dart';
import 'project/authintcation_page.dart';
import 'project/camera.dart';
import 'project/logo.dart';
import 'project/modules/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => SkinfPyProvider(), child: const MyApp()));
}

// runApp(DevicePreview(builder: (context) => ChangeNotifierProvider( create: (context) => SkinfPyProvider(), child: const MyApp())));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(
              0xff46A4FF,
              <int, Color>{
                50: Color(0xff46A4FF),
                100: Color(0xff46A4FF),
                200: Color(0xff46A4FF),
                300: Color(0xff46A4FF),
                400: Color(0xff46A4FF),
                500: Color(0xff46A4FF), // The commonly used shade.
                600: Color(0xff46A4FF),
                700: Color(0xff46A4FF),
                800: Color(0xff46A4FF),
                900: Color(0xff46A4FF), // The darkest shade.
              },
            ),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Logo1(),
      ),
    );
    //Provider.of<SkinfPyProvider>(context).stopLogo ? const AuthintcationPage(): const Logo1(),
  }
}
