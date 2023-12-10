import 'package:flutter/material.dart';
import 'package:mobile_project/models/ss_body.dart';

class SSBodyScreen extends StatelessWidget {
  const SSBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadBody("sycorax"),
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
                Text("Gravity: ${picture.gravity} m/s^2"),
                Text("Semimajor Axis: ${picture.semimajorAxis} km"),
                Text("Orbital inclination: ${picture.inclination}º"),
                Text(
                    "Mass: ${picture.massValue} · 10^${picture.massExponent} kg"),
                Text(
                    "Volume: ${picture.volValue} · 10^${picture.volExponent} km^3"),
                Text("Density: ${picture.density} g/cm^3"),
                Text("Mean Radius: ${picture.meanRadius}"),
                Text("Sideral Orbit Period: ${picture.sideralOrbit} days"),
                Text("Sideral Rotation: ${picture.sideralRotation} hours"),
                Text("Axialt Tilt: ${picture.axialTilt}º"),
                Text("Mean Temperature: ${picture.avgTemp} K"),
                Text("Discovered by: ${picture.discoveredBy}"),
                Text("Discovery date: ${picture.discoveryDate}"),
                Text("Alternative name: ${picture.alternativeName}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
