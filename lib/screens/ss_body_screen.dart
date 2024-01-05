import 'package:flutter/material.dart';
import 'package:mobile_project/models/ss_body.dart';

class SSBodyScreen extends StatelessWidget {
  const SSBodyScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
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
          return Center(
            child: Column(
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
                Text(picture.name),
                Text(picture.bodyType),
                Text(
                  picture.gravity == 0
                      ? "Gravity: Unknown"
                      : "Gravity: ${picture.gravity} m/s^2",
                ),
                Text(
                  picture.semimajorAxis == 0
                      ? "Semimajor Axis: Unknown"
                      : "Semimajor Axis: ${picture.semimajorAxis} km",
                ),
                Text("Orbital inclination: ${picture.inclination}º"),
                Text(
                  picture.massValue == 0
                      ? "Mass: Unknown"
                      : "Mass: ${picture.massValue} · 10^${picture.massExponent} kg",
                ),
                Text(
                  picture.volValue == 0
                      ? "Volume: Unknown"
                      : "Volume: ${picture.volValue} · 10^${picture.volExponent} km^3",
                ),
                Text(
                  picture.density == 0
                      ? "Density: Unknown"
                      : "Density: ${picture.density} g/cm^3",
                ),
                Text(
                  picture.meanRadius == 0
                      ? "Mean radius: Unknown"
                      : "Mean Radius: ${picture.meanRadius}",
                ),
                Text(
                  picture.sideralOrbit == 0
                      ? "Sideral Orbit Period: Unknown"
                      : "Sideral Orbit Period: ${picture.sideralOrbit} days",
                ),
                Text(
                  picture.sideralRotation == 0
                      ? "Sideral Rotation: Unknown"
                      : "Sideral Rotation: ${picture.sideralRotation} hours",
                ),
                Text("Axialt Tilt: ${picture.axialTilt}º"),
                Text("Mean Temperature: ${picture.avgTemp} K"),
                Text(
                  picture.discoveredBy == ""
                      ? "Discovered by: Unknown"
                      : "Discovered by: ${picture.discoveredBy}",
                ),
                Text(
                  picture.discoveryDate == ""
                      ? "Discovery date: Unknown"
                      : "Discovery date: ${picture.discoveryDate}",
                ),
                Text(
                  picture.alternativeName == ""
                      ? "Alternative name: -"
                      : "Alternative name: ${picture.alternativeName}",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
