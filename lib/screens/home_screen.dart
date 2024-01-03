import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Align(
          alignment: Alignment.center,
          child: CustomAppBar(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageButton('DAILY\nPICTURE', 'image1.jpg', context, "/apod"),
                _buildImageButton('ISS\nLOCATION', 'image2.jpg', context, "/isslocation"),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageButton('SOLAR\nSYSTEM', 'image3.jpg', context, "/list"),
                _buildImageButton('SPACE\nROCKS', 'image4.jpg', context, "/"),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageButton('PEOPLE\nIN SPACE', 'image5.jpg', context, "/people"),
                _buildImageButton('OUR\nHOME', 'image6.jpg', context, "/earthview"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 12.0),
        Image.asset(
          'lib/assets/images/icon.png',
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

Widget _buildImageButton(String label, String imagePath, BuildContext context, String routeName) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
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
  );
}