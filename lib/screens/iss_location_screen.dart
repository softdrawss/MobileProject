import 'package:flutter/material.dart';
import 'package:mobile_project/models/iss_location.dart';

class ISSLocationScreen extends StatelessWidget {
  const ISSLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadISSLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final issLocation = snapshot.data!;
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
                const Text("International Space Station"),
                Text("Longitude:${issLocation.longitude}"),
                Text("Latitude:${issLocation.latitude}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
