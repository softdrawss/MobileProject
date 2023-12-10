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
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          // Organize the data by spacecraft
          Map<String, List<PeopleInSpace>> peopleBySpacecraft = {};

          snapshot.data!.forEach((person) {
            if (!peopleBySpacecraft.containsKey(person.craft)) {
              peopleBySpacecraft[person.craft] = [];
            }
            peopleBySpacecraft[person.craft]!.add(person);
          });

          // Display the data
          return ListView.builder(
            itemCount: peopleBySpacecraft.length,
            itemBuilder: (context, index) {
              String spacecraft = peopleBySpacecraft.keys.elementAt(index);
              List<PeopleInSpace> peopleOnSpacecraft =
                  peopleBySpacecraft[spacecraft]!;

              return Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Spacecraft: $spacecraft',
                        style: TextStyle(
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