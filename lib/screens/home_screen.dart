import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/apod");
              },
              child: const Text('APOD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/earthview");
              },
              child: const Text('Earth View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/people");
              },
              child: const Text('People in Space'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/body");
              },
              child: const Text('SS Body'),
            ),
          ],
        ),
      ),
    );
  }
}