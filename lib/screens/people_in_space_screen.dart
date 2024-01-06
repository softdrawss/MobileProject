import 'package:flutter/material.dart';
import 'package:mobile_project/models/people_in_space.dart';

class PeopleInSpaceScreen extends StatelessWidget {
  const PeopleInSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int peopleNum = 0;
    return FutureBuilder<List<PeopleInSpace>>(
      future: loadPeopleInSpace(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(),
            );
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
            peopleNum++;
          }

          // Display data
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Spacer(),
                const Text("People currently on space:", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text((peopleNum.toString()), style: const TextStyle(color: Color.fromARGB(255, 219, 230, 240), fontSize: 120, fontWeight: FontWeight.bold)),
                const Spacer(),
                //SpacePeopleList(peopleBySpacecraft: peopleBySpacecraft),
                ],
                ),
              ),
          );
        }
      },
    );
  }
}

class SpacePeopleList extends StatelessWidget {
  const SpacePeopleList({
    super.key,
    required this.peopleBySpacecraft,
  });

  final Map<String, List<PeopleInSpace>> peopleBySpacecraft;

  @override
  Widget build(BuildContext context) {
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
}

//SpacePeopleList