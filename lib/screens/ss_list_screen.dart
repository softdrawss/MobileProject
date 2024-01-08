import 'package:flutter/material.dart';
import '../widgets/utility_widget.dart';
import '../widgets/ss_list_widget.dart';

class SSList extends StatelessWidget {
  const SSList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 12),
            buildExpandedButton(
                'PLANETS',
                Alignment.center,
                'lib/assets/images/ss_screen/planets.png',
                context,
                "/planetslist"),
            const SizedBox(height: 6),
            buildExpandedButton(
                'DWARF PLANETS',
                Alignment.center,
                'lib/assets/images/ss_screen/dwarf_planets.png',
                context,
                "/dwarflist"),
            const SizedBox(height: 6),
            buildExpandedButton(
                'COMETS',
                Alignment.center,
                'lib/assets/images/ss_screen/comets.png',
                context,
                "/cometslist"),
            const SizedBox(height: 6),
            buildExpandedButton('MOONS', Alignment.center,
                'lib/assets/images/ss_screen/moons.png', context, "/moonlist"),
            const SizedBox(height: 6),
            buildExpandedButton(
                'ASTEROIDS',
                Alignment.center,
                'lib/assets/images/ss_screen/asteroids.png',
                context,
                "/asteroidslist"),
            const SizedBox(height: 6),
            buildExpandedButton('STARS', Alignment.center,
                'lib/assets/images/ss_screen/stars.png', context, "/starslist"),
          ],
        ),
      ),
    );
  }
}

// Due to the planets do not appear in the usual order (from nearest to farest to the sun), I prefered to upload them manually
class PlanetsList extends StatelessWidget {
  const PlanetsList({super.key});

  static const CustomDivider divider =
      CustomDivider(height: 1, color: Color.fromARGB(128, 161, 175, 188));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Planets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          buildBodyButton(
              'MERCURY',
              "lib/assets/images/ss_list_screen/planets/mercury.jpg",
              context,
              "mercure"),
          divider,
          buildBodyButton(
              "VENUS",
              "lib/assets/images/ss_list_screen/planets/venus.jpg",
              context,
              "venus"),
          divider,
          buildBodyButton(
              "EARTH",
              "lib/assets/images/ss_list_screen/planets/earth.jpg",
              context,
              "terre"),
          divider,
          buildBodyButton(
              "MARS",
              "lib/assets/images/ss_list_screen/planets/mars.jpg",
              context,
              "mars"),
          divider,
          buildBodyButton(
              "JUPITER",
              "lib/assets/images/ss_list_screen/planets/jupiter.jpg",
              context,
              "jupiter"),
          divider,
          buildBodyButton(
              "SATURN",
              "lib/assets/images/ss_list_screen/planets/saturn.jpg",
              context,
              "saturne"),
          divider,
          buildBodyButton(
              "URANUS",
              "lib/assets/images/ss_list_screen/planets/uranus.jpg",
              context,
              "uranus"),
          divider,
          buildBodyButton(
              "NEPTUNE",
              "lib/assets/images/ss_list_screen/planets/neptune.jpg",
              context,
              "neptune"),
        ],
      ),
    );
  }
}

// Links may have to be changed

// bodyType -> Comet
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CComet
class CometsList extends StatelessWidget {
  const CometsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Comets'),
        ),
        body: const BodyList(
          url:
              "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CComet",
        ));
  }
}

// bodyType -> Moon
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CMoon
class MoonList extends StatelessWidget {
  const MoonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Moons'),
        ),
        body: const BodyList(
          url:
              "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CMoon",
        ));
  }
}

// bodyType -> Dwarf Planet
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CDwarf%20Planet

class DwarfList extends StatelessWidget {
  const DwarfList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Dwarf Planets'),
        ),
        body: const BodyListImage(
          url:
              "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CDwarf%20Planet",
          folder: "dwarfplanets",
        ));
  }
}

// bodyType -> Asteroid
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CAsteroid
class AsteroidsList extends StatelessWidget {
  const AsteroidsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Asteroids'),
        ),
        body: const BodyList(
          url:
              "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CAsteroid",
        ));
  }
}

// bodyType -> Star
// There is only the sun
class StarsList extends StatelessWidget {
  const StarsList({super.key});

static const CustomDivider divider =
      CustomDivider(height: 1, color: Color.fromARGB(128, 161, 175, 188));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Stars'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          buildBodyButton(
              'SUN',
              "lib/assets/images/ss_list_screen/stars/sun.jpg",
              context,
              "soleil"),
              divider,
        ],
      ),
    );
  }
}

class SSBodyMoonList extends StatelessWidget {
  final String planetID;
  final String planetName;
  const SSBodyMoonList(
      {super.key, required this.planetID, required this.planetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyMoonList(planetID: planetID, planetName: planetName),
    );
  }
}
