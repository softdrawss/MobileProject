import 'package:flutter/material.dart';

class SSList extends StatelessWidget {
  const SSList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: Text("PLANETS"),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: Text("COMETS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: Text("MOONS"),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: Text("DWARF PLANETS"),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: Text("ASTEROIDS"),
            ),
          ],
        )
      ],
    );
  }
}

class MoonList extends StatelessWidget {
  const MoonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: const Text('Planet Moons'),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: const Text('Dwarf Planet Moons'),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("You pressed the button!");
              },
              child: const Text('Asteroid Moons'),
            ),
          ],
        ),
      ),
    );
  }
}
