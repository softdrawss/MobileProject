import 'package:flutter/material.dart';
import 'package:mobile_project/models/ss_body.dart';

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
            padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
                Text(picture.name, style: name),
                Text(picture.bodyType, style: bodyType),
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 161, 175, 188),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          picture.gravity == 0
                              ? "Gravity: Unknown"
                              : "Gravity: ${picture.gravity} m/s^2",
                          style: text,
                        ),
                        Text(
                          picture.semimajorAxis == 0
                              ? "Semimajor Axis: Unknown"
                              : "Semimajor Axis: ${picture.semimajorAxis} km",
                          style: text,
                        ),
                        Text(
                          "Orbital inclination: ${picture.inclination}º",
                          style: text,
                        ),
                        Text(
                          picture.massValue == 0
                              ? "Mass: Unknown"
                              : "Mass: ${picture.massValue} · 10^${picture.massExponent} kg",
                          style: text,
                        ),
                        Text(
                          picture.volValue == 0
                              ? "Volume: Unknown"
                              : "Volume: ${picture.volValue} · 10^${picture.volExponent} km^3",
                          style: text,
                        ),
                        Text(
                          picture.density == 0
                              ? "Density: Unknown"
                              : "Density: ${picture.density} g/cm^3",
                          style: text,
                        ),
                        Text(
                          picture.meanRadius == 0
                              ? "Mean radius: Unknown"
                              : "Mean Radius: ${picture.meanRadius}",
                          style: text,
                        ),
                        Text(
                          picture.sideralOrbit == 0
                              ? "Sideral Orbit Period: Unknown"
                              : "Sideral Orbit Period: ${picture.sideralOrbit} days",
                          style: text,
                        ),
                        Text(
                          picture.sideralRotation == 0
                              ? "Sideral Rotation: Unknown"
                              : "Sideral Rotation: ${picture.sideralRotation} hours",
                          style: text,
                        ),
                        Text(
                          "Axialt Tilt: ${picture.axialTilt}º",
                          style: text,
                        ),
                        Text(
                          "Mean Temperature: ${picture.avgTemp} K",
                          style: text,
                        ),
                        Text(
                          picture.discoveredBy == ""
                              ? "Discovered by: Unknown"
                              : "Discovered by: ${picture.discoveredBy}",
                          style: text,
                        ),
                        Text(
                          picture.discoveryDate == ""
                              ? "Discovery date: Unknown"
                              : "Discovery date: ${picture.discoveryDate}",
                          style: text,
                        ),
                        Text(
                          picture.alternativeName == ""
                              ? "Alternative name: -"
                              : "Alternative name: ${picture.alternativeName}",
                          style: text,
                        ),
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
