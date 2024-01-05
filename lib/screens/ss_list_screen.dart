import 'package:flutter/material.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';
import 'package:mobile_project/models/ss_list.dart';

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

void navigateToBodyDetails(BuildContext context, String planetName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SSBodyScreen(id: planetName),
    ),
  );
}

Widget _buildImageButton(
    String label, String imagePath, BuildContext context, String id) {
  return GestureDetector(
    onTap: () {
      navigateToBodyDetails(context, id);
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: MediaQuery.of(context).size.height / 3 - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
            _buildImageButton(
                "MERCURY", "lib/assets/images/planets/mercury.jpg", context, "mercure"),
            _buildImageButton(
                "Venus", "lib/assets/images/planets/venus.jpg", context, "venus"),
            _buildImageButton(
                "Earth", "lib/assets/images/planets/earth.jpg", context, "terre"),
            _buildImageButton(
                "Mars", "lib/assets/images/planets/mars.jpg", context, "mars"),
            _buildImageButton(
                "Jupiter", "lib/assets/images/planets/jupiter.jpg", context, "jupiter"),
            _buildImageButton(
                "Saturn", "lib/assets/images/planets/saturn.jpg", context, "saturne"),
            _buildImageButton(
                "Uranus", "lib/assets/images/planets/uranus.jpg", context, "uranus"),
            _buildImageButton(
                "Neptune", "lib/assets/images/planets/neptune.jpg", context, "neptune"),
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
