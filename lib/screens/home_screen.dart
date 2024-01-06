import 'package:flutter/material.dart';
import '../widgets/utility_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Align(
          alignment: Alignment.center,
          child: CustomAppBar(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImageButton('DAILY\nPICTURE', 'lib/assets/images/home_screen/daily_picture.png', context, "/apod"),
                buildImageButton('ISS\nLOCATION', 'lib/assets/images/home_screen/iss_location.png', context, "/isslocation"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImageButton('SOLAR\nSYSTEM', 'lib/assets/images/home_screen/solar_system.png', context, "/list"),
                buildImageButton('SPACE\nROCKS', 'lib/assets/images/home_screen/space_rocks.png', context, "/spacerocks"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImageButton('PEOPLE\nIN SPACE', 'lib/assets/images/home_screen/people_in_space.png', context, "/people"),
                buildImageButton('OUR\nHOME', 'lib/assets/images/home_screen/our_home.png', context, "/earthview"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}