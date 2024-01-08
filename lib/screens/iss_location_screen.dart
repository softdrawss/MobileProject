import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/iss_location.dart';
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
    controller.loadVideoById(
        videoId:
            "P9C25Un7xaM"); //The video streaming is the same ID cause the NASA doesn't close the stream
    // Define a timer to update values each second
    everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        future = loadISSLocation();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    everySecond.cancel();
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
              child: ISSLocationInfoWidget(
                  controller: controller, issLocation: issLocation),
            ),
          );
        },
      ),
    );
  }
}

class ISSLocationInfoWidget extends StatelessWidget {
  const ISSLocationInfoWidget({
    super.key,
    required this.controller,
    required this.issLocation,
  });

  final YoutubePlayerController controller;
  final ISSLocation issLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const Text("International Space Station", style: titleStyle),
        const SizedBox(height: 15),
        YoutubePlayer(controller: controller),
        const SizedBox(height: 40),
        Text("UNIX Timestamp:\n\n${issLocation.timestamp}\n\n",
            textAlign: TextAlign.center, style: infoStyle),
        Text("Longitude:\n\n${issLocation.longitude}\n\n",
            textAlign: TextAlign.center, style: infoStyle),
        Text("Latitude:\n\n${issLocation.latitude}",
            textAlign: TextAlign.center, style: infoStyle),
      ],
    );
  }
}
