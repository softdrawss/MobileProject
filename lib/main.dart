import 'package:flutter/material.dart';
import 'package:mobile_project/screens/home_screen.dart';
import 'package:mobile_project/screens/apod_screen.dart';
import 'package:mobile_project/screens/earth_screen.dart';
import 'package:mobile_project/screens/iss_location_screen.dart';
import 'package:mobile_project/screens/people_in_space_screen.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => const HomeScreen(),
        "/apod": (_) => const APODScreen(),
        "/isslocation": (_) => const ISSLocationScreen(),
        "/earthview": (_) => const EarthViewScreen(),
        "/people": (_) => const PeopleInSpaceScreen(),
        "/body": (_) => const SSBodyScreen(),
      },
      initialRoute: "/",
    );
  }
}
