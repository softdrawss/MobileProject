import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/LL2_astronauts.dart';
import '../widgets/utility_widget.dart';


class AstronautDetailsPopup extends StatelessWidget {
  final Astronaut info;

  const AstronautDetailsPopup({
    super.key, 
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.62,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(220, 6, 30, 52),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(info.profileImage)
              )
            ),
          ),
          const SizedBox(height: 32),
          Text(
            info.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status: ${info.status.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Type: ${info.type.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'In Space: ${info.inSpace}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Time in Space: ${info.timeInSpace}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Age: ${info.age}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Date of Birth: ${info.dateOfBirth}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Date of Death: ${info.dateOfDeath}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Nationality: ${info.nationality}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Bio: ${info.bio}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12),
                  
                  // Add more fields as needed
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  launchURL(info.twitter);
                },
                icon: const Icon(FontAwesomeIcons.twitter),
                tooltip: 'Twitter',
              ),
              IconButton(
                onPressed: () {
                  launchURL(info.instagram);
                },
                icon: const Icon(FontAwesomeIcons.instagram),
                tooltip: 'Instagram',
              ),
              IconButton(
                onPressed: () {
                  launchURL(info.wiki);
                },
                icon: const Icon(FontAwesomeIcons.wikipediaW),
                tooltip: 'Wiki',
              ),
            ],
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}