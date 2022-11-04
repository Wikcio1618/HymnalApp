import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hymnal_app/root.dart';

import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

import 'model/collection.dart';

// TODO - note for future me:
// firestore problems are gone. if they are there checkout GitHub folder. Firestore in branch firestore
// I went into a rabbit hole trying to keep state of separate navigation pages and call animations when doing so.
// It was an upstream struggle so there might have been added appriopriate tools to use routing by the time I come back to this project
// However I might be on the verge of finishing needed changes to do so (deleteRoutes branch). As you can see animation and state is working, but I only replaced category_discover route
// When it comes to data maintanance I went for online database beacause it might be more convenient. Voting may be implemented and songs updated in real time. User needs internet connection though
// What I havent figured out is how to store ~akordy~. Using array to get info about position and type of ~akord~ is best i came up with. Then go with latex package. Maybe use HTML?

void main() async {
  // Hive.init(Directory.current.path);
  // await Hive.openBox<Collection>('collections');

  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateAndSongNotifier(),
      child: MaterialApp(
        home: const RootPage(),
        /*  onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/song":
              return MaterialPageRoute(builder: (context) => const Song());
            case "/search":
              return MaterialPageRoute(builder: (context) => const Search());
            case "/collections":
              return MaterialPageRoute(
                  builder: (context) => const Collections());
            default:
              return MaterialPageRoute(builder: (context) => const RootPage());
          }
        }, */
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 245, 247, 234),
          scaffoldBackgroundColor: const Color.fromARGB(255, 248, 246, 242),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 245, 243, 238),
            titleTextStyle: TextStyle(
                color: Colors.grey[800],
                letterSpacing: 1.5,
                fontSize: 27,
                fontWeight: FontWeight.bold),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: const Color.fromARGB(255, 241, 248, 244),
              selectedItemColor: Colors.green[800]),
          dividerColor: Colors.black87,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.green[800]!,
            onPrimary: const Color.fromARGB(255, 31, 30, 30),
            secondary: const Color.fromARGB(255, 185, 113, 18),
            onSecondary: const Color.fromARGB(255, 255, 255, 255),
            error: const Color.fromARGB(255, 151, 48, 48),
            onError: const Color.fromARGB(255, 251, 250, 250),
            background: const Color.fromARGB(255, 197, 193, 193),
            onBackground: const Color.fromARGB(255, 225, 244, 230),
            surface: const Color.fromARGB(255, 251, 250, 250),
            onSurface: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
