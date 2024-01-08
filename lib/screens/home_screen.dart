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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(220, 6, 30, 52),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 60,
            alignment: Alignment.center,
            child: const Text(
              '',
            ),
          ),
          buildListTile('GitHub', () {
            launchURL('https://github.com/softdrawss/MobileProject');
          }),
          buildListTile('Members', () {}, sublist: [
            const ListTile(title: Text('Arnau Jiménez')),
            const ListTile(title: Text('Ariadna Sevcik')),
            const ListTile(title: Text('Júlia Serra')),
            const ListTile(title: Text('Héctor Báscones')),
          ]),
          buildListTile('APIs used', () {}, sublist: [
            ListTile(
              title: const Text('Daily Astronomy Picture'),
              onTap: () {launchURL('https://github.com/nasa/apod-api');},
            ),
            ListTile(
              title: const Text('ISS Current Location'),
              onTap: () {launchURL('http://open-notify.org/Open-Notify-API/ISS-Location-Now/');},
            ),
            ListTile(
              title: const Text('Solar System'),
              onTap: () {launchURL('https://api.le-systeme-solaire.net/en/');},
            ),
            ListTile(
              title: const Text('People in Space:'),
              onTap: () {launchURL('http://open-notify.org/Open-Notify-API/People-In-Space/');},
            ),
            ListTile(
              title: const Text('Earth View'),
              onTap: () {launchURL('https://epic.gsfc.nasa.gov/about/api');},
            ),
          ]),
        ],
      ),
    );
  }
}

Widget buildListTile(String title, Function() onTap, {List<Widget>? sublist}) {

  final ThemeData customTheme = ThemeData.dark().copyWith(
    dividerColor: Colors.transparent,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color.fromARGB(255, 161, 175, 188)
      ),
    ),
  );

  return sublist == null
  ? Theme(
      data: customTheme,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            //color: Color.fromARGB(255, 161, 175, 188)
          ),
        ),
        onTap: onTap,
      ),
    )
  : Theme(
      data: customTheme,
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            //color: Color.fromARGB(255, 161, 175, 188)
          ),
        ),
        children: sublist
            .map(
              (child) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    child,
                    const Divider(
                      height: 0.2,
                      //color: Color.fromARGB(128, 96, 125, 139),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
}