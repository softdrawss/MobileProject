import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class SpaceRocksScreen extends StatefulWidget {
  const SpaceRocksScreen({super.key});

  @override
  State<SpaceRocksScreen> createState() => _SpaceRocksScreenState();
}

class _SpaceRocksScreenState extends State<SpaceRocksScreen> {

  final PageController  _pageController = PageController();

  int _activePage = 0;

  void onNextPage(){
    if(_activePage  < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,);
    }
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'lib/assets/images/spacerocks_screen/asteroid.png',
      'title': 'Asteroids',
      'description':
        'Remnants left over from the formation of our solar system, ranging in size from the length of a car to about as wide as a large city.\n\n'
        'Asteroids are diverse in composition, some are metallic while others are rich in carbon, giving them a coal-black color.\n'
        'Most of the asteroids in our solar system reside in a region called the main asteroid belt, between the orbits of Mars and Jupiter.\n\n'
        'With all due respect to C3PO, the odds of flying through the asteroid belt without colliding with one are actually pretty good.'
    },
    {
      'image': 'lib/assets/images/spacerocks_screen/comet.png',
      'title': 'Comets',
      'description':
        'Comets also orbit the Sun, but they are more like snowballs than space rocks. Each comet has a center called a nucleus that contains icy chunks of frozen gases, along with bits of rock and dust.\n\n'
        'When a comet’s orbit brings it close to the Sun, the comet heats up and spews dust and gases, forming a giant, glowing ball called a coma around its nucleus, along with two tails, one made of dust and the other of excited gas (ions).\n\n'
        'Driven by a constant flow of particles from the Sun called the solar wind, the tails point away from the Sun, sometimes stretching for millions of miles.'
    },
    {
      'image': 'lib/assets/images/spacerocks_screen/meteoroid.png',
      'title': 'Meteoroids',
      'description':
        'Meteoroids are fragments and debris in space resulting from collisions among asteroids, comets, moons, and planets.\n\n'
        'They are among the smallest “space rocks.” We can see them when they streak through our atmosphere in the form of meteors and meteor showers.',
    },
    {
      'image': 'lib/assets/images/spacerocks_screen/meteor.png',
      'title': 'Meteors',
      'description':
        'Meteors are meteoroids that fall through Earth’s atmosphere at extremely high speeds. The pressure and heat they generate as they push through the air causes them to glow and create streaks of light in the sky.\n\n'
        'Most burn up completely before touching the ground. We often refer to them as “shooting stars.” Meteors may be made mostly of rock, metal, or a combination of the two.\n\n'
        'Scientists estimate that about 48 tons (48,000 kilograms) of meteoritic material fall on the Earth each day.'
    },
    {
      'image': 'lib/assets/images/spacerocks_screen/meteorite.png',
      'title': 'Meteorites',
      'description':
        'Meteorites are fragments of asteroids, comets, moons, and planets that survive the heated journey through Earth’s atmosphere all the way to the ground. Most meteorites found on Earth are pebble to fist size, but some are larger than a building.\n\n'
        'Early Earth experienced many large meteorite impacts that caused extensive destruction. Well-documented stories of modern meteorite-caused injury or death are rare. In the first known case of an extraterrestrial object to have injured a human being in the U.S., Ann Hodges of Sylacauga, Alabama, was severely bruised by an 8-pound (3.6-kilogram) stony meteorite that crashed through her roof in November 1954.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            scrollBehavior: AppScrollBehavior(),
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index){
              return SpaceRockWidget(
                index: index,
                image: _pages[index]['image'],
                title: _pages[index]['title'],
                description: _pages[index]['description'],
                onTab: onNextPage,
              );
            }
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 32,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator()
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators =  <Widget>[];

    for(var i = 0; i < _pages.length; i++) {

      if(_activePage == i) {
        indicators.add(_indicatorsTrue());
      }
      else{
        indicators.add(_indicatorsFalse());
      }
    }
    return  indicators;
  }

  Widget _indicatorsTrue() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 400),
      height: 4,
      width: 24,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 400),
      height: 6,
      width: 6,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade600,
      ),
    );
  }
}

class SpaceRockWidget extends StatelessWidget {
  const SpaceRockWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onTab,
    required this.index
  });

  final String image;
  final String title;
  final String description;
  final VoidCallback onTab;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(255, 4, 11, 25),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.86,
            child: Align(
              alignment: Alignment.center,
              child: ImageWithGradientFade(imagePath: image),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: const BoxDecoration(
                color: Color.fromARGB(220, 6, 30, 52),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Text(title, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20,),
                    Text(description, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.grey), textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithGradientFade extends StatelessWidget {
  const ImageWithGradientFade({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 0.1, 0.94, 1.0], // Adjust stops for a more even fade
          colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(imagePath),
    );
  }
}