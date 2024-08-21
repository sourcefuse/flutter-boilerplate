import 'dart:async';

import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  /// The code snippet you provided is using `runZonedGuarded` function in Dart.
  await runZonedGuarded(() async {
    /// `WidgetsFlutterBinding.ensureInitialized();` is ensuring that the Flutter framework is properly
    /// initialized before proceeding with the application's main logic. This function call is typically
    /// used at the beginning of a Flutter application to make sure that the necessary bindings and services
    /// are set up before any UI rendering or other operations take place. It helps in preventing issues
    /// related to uninitialized Flutter bindings and ensures a smooth start for the application.
    WidgetsFlutterBinding.ensureInitialized();

    /// `await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` is initializing
    /// the Firebase services in the Flutter application. This function call initializes Firebase with
    /// the provided options, which are specified in `DefaultFirebaseOptions.currentPlatform`. This step
    /// is crucial for setting up Firebase services like Firestore, Authentication, Cloud Messaging,
    /// etc., in the application before using any Firebase-related functionality.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// `await setUpLocator();` is likely a function call that sets up a service locator or dependency
    /// injection container in the Flutter application. In the context of clean architecture or similar
    /// design patterns, a service locator is used to manage the dependencies of various components in the
    /// application.
    await setUpLocator();

    /// `await ScreenUtil.ensureScreenSize();` in the provided code snippet is a call to the
    /// `ensureScreenSize` method provided by the `flutter_screenutil` package.
    await ScreenUtil.ensureScreenSize();

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return const MaterialApp(
          home: HomePage(),
        );
      },
    );
  }
}
