import 'package:flutter/material.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';

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

void _navigateToPlanetDetails(BuildContext context, String planetName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SSBodyScreen(id: planetName.toLowerCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "mercure");
              },
              child: const Text("Mercury"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "venus");
              },
              child: const Text("Venus"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "terre");
              },
              child: const Text("Earth"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "mars");
              },
              child: const Text("Mars"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "jupiter");
              },
              child: const Text("Jupiter"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "saturne");
              },
              child: const Text("Saturn"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "uranus");
              },
              child: const Text("Uranus"),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToPlanetDetails(context, "neptune");
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
