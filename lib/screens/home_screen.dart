import 'package:flutter/material.dart';
import '../widgets/utility_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildExpandedRow([
              buildExpandedButton('DAILY\nPICTURE', Alignment.bottomLeft, 'lib/assets/images/home_screen/daily_picture.png', context, "/apod"),
              const SizedBox(width: 6),
              buildExpandedButton('ISS\nLOCATION', Alignment.bottomLeft, 'lib/assets/images/home_screen/iss_location.png', context, "/isslocation"),
            ]),
            const SizedBox(height: 6),
            buildExpandedRow([
              buildExpandedButton('SOLAR\nSYSTEM', Alignment.bottomLeft, 'lib/assets/images/home_screen/solar_system.png', context, "/list"),
              const SizedBox(width: 6),
              buildExpandedButton('SPACE\nROCKS', Alignment.bottomLeft, 'lib/assets/images/home_screen/space_rocks.png', context, "/spacerocks"),
            ]),
            const SizedBox(height: 6),
            buildExpandedRow([
              buildExpandedButton('PEOPLE\nIN SPACE', Alignment.bottomLeft, 'lib/assets/images/home_screen/people_in_space.png', context, "/people"),
              const SizedBox(width: 6),
              buildExpandedButton('OUR\nHOME', Alignment.bottomLeft, 'lib/assets/images/home_screen/our_home.png', context, "/earthview"),
            ]),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 12.0),
          Image.asset(
            'lib/assets/images/home_screen/icon.png',
            height: 48.0,
            width: 48.0,
          ),
          const SizedBox(width: 12.0),
          const Text(
            'Space App',
            style: TextStyle(
              color: Color(0xFFDBE6F0),
              fontSize: 32,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Item 1',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}