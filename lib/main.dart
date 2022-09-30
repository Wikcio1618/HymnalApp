import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hymnal_app/root.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 190, 136, 86),
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        secondary: Color.fromARGB(255, 118, 79, 43),
        onSecondary: Color.fromARGB(255, 255, 255, 255),
        error: Color.fromARGB(255, 151, 48, 48),
        onError: Color.fromARGB(255, 251, 250, 250),
        background: Color.fromARGB(255, 231, 230, 230),
        onBackground: Color.fromARGB(255, 0, 0, 0),
        surface: Color.fromARGB(255, 251, 250, 250),
        onSurface: Color.fromARGB(255, 0, 0, 0),
      )),
      home: const RootPage(),
    );
  }
}
