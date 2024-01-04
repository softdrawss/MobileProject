import 'package:flutter/material.dart';
import 'package:mobile_project/models/apod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../widgets/chooseAPOD_date_widget.dart';

class APODScreen extends StatefulWidget {
  const APODScreen({super.key});

  @override
  State<APODScreen> createState() => _APODScreenState();
}

class _APODScreenState extends State<APODScreen> {
  DateTime dateTime = DateTime.now();

  ChooseDateWidget? dateWidget;

  final controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
        future: loadAPOD(dateTime.toString().split(" ")[0]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final picture = snapshot.data!;
          if (picture.type == "video") {
            controller.loadVideoByUrl(mediaContentUrl: picture.url);
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.05, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        picture.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      if (picture.copyright != null)
                        Text(
                          picture.copyright.toString(),
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15),
                        ),
                      if (picture.type == "video")
                        YoutubePlayer(
                          controller: controller,
                        )
                      else
                        Image(image: NetworkImage(picture.url)),
                      const SizedBox(height: 15),
                      ChooseDateWidget(
                          dateTime: dateTime,
                          onDateChanged: (newDateTime) {
                            setState(() {
                              dateTime = newDateTime;
                            });
                          }),
                      const SizedBox(height: 15),
                      Text(
                        picture.explanation,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
