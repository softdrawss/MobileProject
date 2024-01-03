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
                Navigator.pushNamed(context, "/asteroidslist");
              },
              child: const Text("ASTEROIDS"),
            ),
          ],
        )
      ],
    );
  }
}

class PlanetsList extends StatelessWidget {
  const PlanetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Mercury"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Venus"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Earth"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Mars"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Jupiter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Saturn"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Uranus"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/moonlist");
              },
              child: const Text("Neptune"),
            ),
          ],
        ),
      ],
    );
  }
}

class CometsList extends StatelessWidget {
  const CometsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MoonList extends StatelessWidget {
  const MoonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
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
      ],
    );
  }
}

class DwarfList extends StatelessWidget {
  const DwarfList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AsteroidsList extends StatelessWidget {
  const AsteroidsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
