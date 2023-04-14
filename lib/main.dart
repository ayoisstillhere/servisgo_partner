import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ServisGo Partner',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darktheme,
      home: const OnboardingScreen(),
    );
  }
}
