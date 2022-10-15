import 'package:flutter/material.dart';
import 'package:hymnal_app/root.dart';

import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

// TODO - note for future me:
// firestore problems are gone. if they are there checkout GitHub folder. Firestore in branch firestore
// I went into a rabbit hole trying to keep state of separate navigation pages and call animations when doing so.
// It was an upstream struggle so there might have been added appriopriate tools to use routing by the time I come back to this project
// However I might be on the verge of finishing needed changes to do so (deleteRoutes branch). As you can see animation and state is working, but I only replaced category_discover route
// When it comes to data maintanance I went for online database beacause it might be more convenient. Voting may be implemented and songs updated in real time. User needs internet connection though
// What I havent figured out is how to store ~akordy~. Using array to get info about position and type of ~akord~ is best i came up with. Then go with latex package. Maybe use HTML?

void main() {
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
          ),
        ),
      ),
    );
  }
}
