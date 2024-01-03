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
                Navigator.pushNamed(context, "/planetslist");
              },
              child: const Text("PLANETS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cometslist");
              },
              child: const Text("COMETS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("MOONS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/dwarflist");
              },
              child: const Text("DWARF PLANETS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/asteroidlist");
              },
              child: const Text("ASTEROIDS"),
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
