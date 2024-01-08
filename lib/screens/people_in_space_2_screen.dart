import 'package:flutter/material.dart';
import 'package:mobile_project/models/people_in_space_2.dart';


class AstronautListScreen extends StatelessWidget {
  const AstronautListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astronaut List'),
      ),
      body: FutureBuilder<AstronautResponse>(
        future: loadAstronauts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading astronauts');
          } else if (!snapshot.hasData || snapshot.data?.results == null) {
            return const Text('No astronauts available');
          }

          final astronauts = snapshot.data!.results;

          return ListView.builder(
            itemCount: astronauts.length,
            itemBuilder: (context, index) {
              final astronaut = astronauts[index];
              return ListTile(
                title: Text(astronaut.name),
                subtitle: Text('Nationality: ${astronaut.nationality}'),
                onTap: () {
                  // Handle astronaut tap
                },
              );
            },
          );
        },
      ),
    );
  }
}