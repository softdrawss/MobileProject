import 'package:flutter/material.dart';
import 'package:mobile_project/models/people_in_space.dart';

class PeopleInSpaceScreen extends StatelessWidget {
  const PeopleInSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadPeopleInSpace(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final people = snapshot.data!;

          return Center(
            child: Column(
              children: [
                Text(people.length.toString()),
                Text(people[0].name),
                Text(people[0].craft),
                Text(people[1].name),
                Text(people[1].craft),
              ],
            ),
          );
        },
      ),
    );
  }
}
