import 'package:flutter/material.dart';
import 'package:mobile_project/models/people_in_space.dart';

class PeopleInSpaceScreen extends StatelessWidget {
  const PeopleInSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PeopleInSpace>>(
      future: loadPeopleInSpace(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          // Organize data by spacecraft
          Map<String, List<PeopleInSpace>> peopleBySpacecraft = {};

          for (var person in snapshot.data!) {
            if (!peopleBySpacecraft.containsKey(person.craft)) {
              peopleBySpacecraft[person.craft] = [];
            }
            peopleBySpacecraft[person.craft]!.add(person);
          }

          // Display data
          return ListView.builder(
            itemCount: peopleBySpacecraft.length,
            itemBuilder: (context, index) {
              String spacecraft = peopleBySpacecraft.keys.elementAt(index);
              List<PeopleInSpace> peopleOnSpacecraft =
                  peopleBySpacecraft[spacecraft]!;

              return Card(
                margin: const EdgeInsets.all(8.0),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Spacecraft: $spacecraft',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Column(
                      children: peopleOnSpacecraft
                          .map(
                            (person) => ListTile(
                              title: Text(person.name),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}