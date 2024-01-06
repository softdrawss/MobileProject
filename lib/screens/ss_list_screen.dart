import 'package:flutter/material.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';
import 'package:mobile_project/models/ss_list.dart';
import '../widgets/utility_widget.dart';


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
            buildExpandedButton('PLANETS', Alignment.center, 'lib/assets/images/ss_screen/planets.png', context, "/planetslist"),
            const SizedBox(height: 6),
            buildExpandedButton('COMETS', Alignment.center, 'lib/assets/images/ss_screen/comets.png', context, "/cometslist"),
            const SizedBox(height: 6),
            buildExpandedButton('MOONS', Alignment.center, 'lib/assets/images/ss_screen/moons.png', context, "/moonlist"),
            const SizedBox(height: 6),
            buildExpandedButton('DWARF PLANETS', Alignment.center, 'lib/assets/images/ss_screen/dwarf_planets.png', context, "/dwarflist"),
            const SizedBox(height: 6),
            buildExpandedButton('ASTEROIDS', Alignment.center, 'lib/assets/images/ss_screen/asteroids.png', context, "/asteroidslist"),
          ],
        ),
      ),
    );
  }
}

void navigateToBodyDetails(BuildContext context, String planetName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SSBodyScreen(id: planetName),
    ),
  );
}

Widget _buildImageButton(String label, String imagePath, BuildContext context, String id) {
  return GestureDetector(
    onTap: () {
      navigateToBodyDetails(context, id);
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height / 3 - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 219, 230, 240), width: 2), // Add white border
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 219, 230, 240),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none, // Remove text decoration
            ),
          ),
        ),
      ),
    ),
  );
}

// Due to the planets do not appear in the usual order (from nearest to farest to the sun), I prefered to upload them manually
class PlanetsList extends StatelessWidget {
  const PlanetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
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
            _buildImageButton('Mercury',
                "lib/assets/images/planets/mercury.jpg", context, "mercure"),
            const SizedBox(height: 10),
            _buildImageButton("Venus", "lib/assets/images/planets/venus.jpg",
                context, "venus"),
            const SizedBox(height: 10),
            _buildImageButton("Earth", "lib/assets/images/planets/earth.jpg",
                context, "terre"),
            const SizedBox(height: 10),
            _buildImageButton(
                "Mars", "lib/assets/images/planets/mars.jpg", context, "mars"),
            const SizedBox(height: 10),
            _buildImageButton("Jupiter",
                "lib/assets/images/planets/jupiter.jpg", context, "jupiter"),
            const SizedBox(height: 10),
            _buildImageButton("Saturn", "lib/assets/images/planets/saturn.jpg",
                context, "saturne"),
            const SizedBox(height: 10),
            _buildImageButton("Uranus", "lib/assets/images/planets/uranus.jpg",
                context, "uranus"),
            const SizedBox(height: 10),
            _buildImageButton("Neptune",
                "lib/assets/images/planets/neptune.jpg", context, "neptune"),
          ],
        ),
      ],
    );
  }
}

// Links may have to be changed

// bodyType -> Comet
// To see all the elements:
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CComet
class CometsList extends StatelessWidget {
  const CometsList({super.key});

  final String url =
      "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CComet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Bodies"),
      ),
      body: FutureBuilder(
        future: loadList(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<ListedBody> bodyList = snapshot.data as List<ListedBody>;

            return ListView.builder(
              itemCount: bodyList.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    navigateToBodyDetails(context, bodyList[index].id);
                  },
                  child: Text(bodyList[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// bodyType -> Moon
// To see all the elements:
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CMoon
class MoonList extends StatelessWidget {
  const MoonList({super.key});

  final String url =
      "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CMoon";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Moons"),
      ),
      body: FutureBuilder(
        future: loadList(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<ListedBody> bodyList = snapshot.data as List<ListedBody>;

            return ListView.builder(
              itemCount: bodyList.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    navigateToBodyDetails(context, bodyList[index].id);
                  },
                  child: Text(bodyList[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// bodyType -> Dwarf Planet
// To see all the elements:
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CDwarf%20Planet

class DwarfList extends StatelessWidget {
  const DwarfList({super.key});

  final String url =
      "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CDwarf%20Planet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Dwarf Planets"),
      ),
      body: FutureBuilder(
        future: loadList(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<ListedBody> bodyList = snapshot.data as List<ListedBody>;

            return ListView.builder(
              itemCount: bodyList.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    navigateToBodyDetails(context, bodyList[index].id);
                  },
                  child: Text(bodyList[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// bodyType -> Asteroid
// To see all the elements:
// https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CAsteroid
class AsteroidsList extends StatelessWidget {
  const AsteroidsList({super.key});

  final String url =
      "https://api.le-systeme-solaire.net/rest.php/bodies?data=id%2CenglishName&filter%5B%5D=bodyType%2Ceq%2CAsteroid";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Asteroids"),
      ),
      body: FutureBuilder(
        future: loadList(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<ListedBody> bodyList = snapshot.data as List<ListedBody>;

            return ListView.builder(
              itemCount: bodyList.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    navigateToBodyDetails(context, bodyList[index].id);
                  },
                  child: Text(bodyList[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}
