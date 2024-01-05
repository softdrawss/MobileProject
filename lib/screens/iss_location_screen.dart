import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/iss_location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ISSLocationScreen extends StatefulWidget {
  const ISSLocationScreen({super.key});

  @override
  State<ISSLocationScreen> createState() => _ISSLocationScreenState();
}

class _ISSLocationScreenState extends State<ISSLocationScreen> {
  final controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  late Timer everySecond;
  late Future future;
  @override
  void initState() {
    super.initState();
    controller.loadVideoById(videoId: "P9C25Un7xaM");
    // Define a timer
    everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        future = loadISSLocation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
        future: future = loadISSLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final issLocation = snapshot.data!;
          return Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.05, 0),
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    "International Space Station",
                    style: GoogleFonts.play(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  YoutubePlayer(controller: controller),
                  const SizedBox(height: 40),
                  Text(
                    "UNIX Timestamp:\n\n${issLocation.timestamp}\n\n",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Longitude:\n\n${issLocation.longitude}\n\n",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Latitude:\n\n${issLocation.latitude}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
