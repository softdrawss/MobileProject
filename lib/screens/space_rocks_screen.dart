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
      'image': 'assets/images/image1.png',
      'title': 'Asteroids',
      'description':
        'Remnants left over from the formation of our solar system, ranging in size from the length of a car to about as wide as a large city.\n\n'
        'Asteroids are diverse in composition, some are metallic while others are rich in carbon, giving them a coal-black color.\n\n'
        'Most of the asteroids in our solar system reside in a region called the main asteroid belt, between the orbits of Mars and Jupiter.\n\n'
        'With all due respect to C3PO, the odds of flying through the asteroid belt without colliding with one are actually pretty good.'
    },
    {
      'image': 'assets/images/image2.png',
      'title': 'Comets',
      'description':
        'Comets also orbit the Sun, but they are more like snowballs than space rocks. Each comet has a center called a nucleus that contains icy chunks of frozen gases, along with bits of rock and dust.\n\n'
        'When a comet’s orbit brings it close to the Sun, the comet heats up and spews dust and gases, forming a giant, glowing ball called a coma around its nucleus, along with two tails, one made of dust and the other of excited gas (ions).\n\n'
        'Driven by a constant flow of particles from the Sun called the solar wind, the tails point away from the Sun, sometimes stretching for millions of miles.'
    },
    {
      'image': 'assets/images/image3.png',
      'title': 'Meteoroids',
      'description':
        'Meteoroids are fragments and debris in space resulting from collisions among asteroids, comets, moons, and planets.\n\n'
        'They are among the smallest “space rocks.” We can see them when they streak through our atmosphere in the form of meteors and meteor showers.',
    },
    {
      'image': 'assets/images/image4.png',
      'title': 'Meteors',
      'description':
        'Meteors are meteoroids that fall through Earth’s atmosphere at extremely high speeds. The pressure and heat they generate as they push through the air causes them to glow and create streaks of light in the sky.\n\n'
        'Most burn up completely before touching the ground. We often refer to them as “shooting stars.” Meteors may be made mostly of rock, metal, or a combination of the two.\n\n'
        'Scientists estimate that about 48 tons (48,000 kilograms) of meteoritic material fall on the Earth each day.'
    },
    {
      'image': 'assets/images/image5.png',
      'title': 'Meteorites',
      'description':
        'Meteors can usually be seen on any clear night throughout the year. Sometimes the number increases dramatically – these events are termed meteor showers.\n\n'
        'They occur when Earth passes through trails of particles left by comets. When the particles enter Earth’s atmosphere, they burn up, creating hundreds or even thousands of bright streaks in the sky.\n\n'
        'We can easily plan when to watch meteor showers because numerous showers happen annually as Earth’s orbit takes it through the same patches of comet debris.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      duration: const Duration(microseconds: 300),
      height: 4,
      width: 32,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
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
          Container(
            height: MediaQuery.of(context).size.height / 1.86,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill
              )
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
                    Text(title, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20,),
                    Text(description, style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.grey), textAlign: TextAlign.justify,)
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