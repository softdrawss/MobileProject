import 'package:flutter/material.dart';
import 'package:mobile_project/screens/home_screen.dart';
import 'package:mobile_project/screens/space_rocks_screen.dart';
import 'package:mobile_project/screens/ss_list_screen.dart';
import 'package:mobile_project/screens/apod_screen.dart';
import 'package:mobile_project/screens/earth_screen.dart';
import 'package:mobile_project/screens/iss_location_screen.dart';
import 'package:mobile_project/screens/people_in_space_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: const Color.fromARGB(255, 30, 20, 44),
              onPrimary: Colors.white,
              secondary: const Color.fromARGB(255, 80, 54, 116),
              onSecondary: Colors.white,
              error: Colors.red.shade800,
              onError: Colors.white,
              background: const Color.fromARGB(255, 4, 11, 25),
              onBackground: Colors.white,
              surface: const Color.fromARGB(255, 161, 175, 188),
              onSurface: const Color.fromARGB(255, 161, 175, 188))),
      routes: {
        "/": (_) => const HomeScreen(),
        "/apod": (_) => const APODScreen(),
        "/isslocation": (_) => const ISSLocationScreen(),
        "/list": (_) => const SSList(),
        "/planetslist": (_) => const PlanetsList(),
        "/cometslist": (_) => const CometsList(),
        "/moonlist": (_) => const MoonList(),
        "/dwarflist": (_) => const DwarfList(),
        "/asteroidslist": (_) => const AsteroidsList(),
        "/starslist": (_) => const StarsList(),
        "/spacerocks": (_) => const SpaceRocksScreen(),
        "/people": (_) => const PeopleInSpaceScreen(),
        "/earthview": (_) => const EarthViewScreen(),
      },
      initialRoute: "/",
    );
  }
}
