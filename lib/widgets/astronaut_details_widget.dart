import 'package:flutter/material.dart';
import '../models/LL2_astronauts.dart';

class AstronautDetailsPopup extends StatelessWidget {
  final Astronaut info;

  const AstronautDetailsPopup({
    super.key, 
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.6,
      decoration: const BoxDecoration(
        color: Color.fromARGB(220, 6, 30, 52),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            info.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                info.bio,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}