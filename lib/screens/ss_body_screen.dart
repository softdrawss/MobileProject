import 'package:flutter/material.dart';
import 'package:mobile_project/models/ss_body.dart';
import 'package:mobile_project/screens/ss_list_screen.dart';
import '../widgets/utility_widget.dart';

void navigateToMoonList(BuildContext context, String planetID, String planetName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SSBodyMoonList(planetID: planetID, planetName: planetName),
    ),
  );
}

class SSBodyScreen extends StatelessWidget {
  SSBodyScreen({super.key, required this.id});

  final String id;

  TextStyle name = const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 219, 230, 240));
  TextStyle bodyType = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(255, 219, 230, 240));
  TextStyle text = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height / 3 - 48;

    return Scaffold(
      body: FutureBuilder(
        future: loadBody(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          final picture = snapshot.data!;
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(picture.name, style: name),
                Text(picture.bodyType, style: bodyType),
                bodyInformation(picture, screenWidth),
                const SizedBox(height: 20),
                if (picture.moons.isNotEmpty)
                  bodyMoons(
                    picture,
                    context,
                    picture.id,
                    picture.name,
                    screenWidth,
                    screenHeight,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget bodyInformation(final picture, double screenWidth) {
  return Container(
    width: screenWidth,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 161, 175, 188),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRichText("Gravity:",
            picture.gravity == 0 ? "Unknown" : "${picture.gravity} m/s^2"),
        buildRichText(
            "Semimajor Axis:",
            picture.semimajorAxis == 0
                ? "Unknown"
                : "${picture.semimajorAxis} km"),
        buildRichText("Orbital inclination:", "${picture.inclination}º"),
        buildRichText(
            "Mass:",
            picture.massValue == 0
                ? "Unknown"
                : "${picture.massValue} · 10^${picture.massExponent} kg"),
        buildRichText(
            "Volume:",
            picture.volValue == 0
                ? "Unknown"
                : "${picture.volValue} · 10^${picture.volExponent} km^3"),
        buildRichText("Density:",
            picture.density == 0 ? "Unknown" : "${picture.density} g/cm^3"),
        buildRichText("Mean Radius:",
            picture.meanRadius == 0 ? "Unknown" : "${picture.meanRadius} km"),
        buildRichText(
            "Sideral Orbit Period:",
            picture.sideralOrbit == 0
                ? "Unknown"
                : "${picture.sideralOrbit} days"),
        buildRichText(
            "Sideral Rotation:",
            picture.sideralRotation == 0
                ? "Unknown"
                : "${picture.sideralRotation} hours"),
        buildRichText("Axial Tilt:", "${picture.axialTilt}º"),
        buildRichText("Mean Temperature:", "${picture.avgTemp} K"),
        buildRichText("Discovered by:",
            picture.discoveredBy == "" ? "Unknown" : "${picture.discoveredBy}"),
        buildRichText(
            "Discovery date:",
            picture.discoveryDate == ""
                ? "Unknown"
                : "${picture.discoveryDate}"),
        buildRichText("Alternative name:",
            picture.alternativeName == "" ? "-" : "${picture.alternativeName}"),
      ],
    ),
  );
}

Widget bodyMoons(final picture, final context, String planetID, String planetName,
    double screenWidth, double screenHeight) {
  return GestureDetector(
    onTap: () {
      navigateToMoonList(context, planetID, planetName);
    },
    child: Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(255, 219, 230, 240),
            width: 2), // Add white border
        image: const DecorationImage(
            image: AssetImage("lib/assets/images/ss_body_screen/moons.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8),
      ),
      child: Material(
        color: const Color.fromARGB(0, 0, 0, 0),
        child: InkWell(
          onTap: () {
            navigateToMoonList(context, planetID, planetName);
          },
          splashColor: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SEE MOONS IN ${picture.name.toUpperCase()}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 219, 230, 240),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none, // Remove text decoration
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
