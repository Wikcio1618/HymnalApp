import 'package:flutter/material.dart';
import 'package:hymnal_app/root.dart';
import 'package:hymnal_app/services/song_notifier.dart';
import 'package:hymnal_app/services/state_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StateNotifier()),
        ChangeNotifierProvider(create: (context) => SongNotifier())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
