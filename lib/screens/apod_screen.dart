import 'package:flutter/material.dart';
import 'package:mobile_project/models/apod.dart';
import 'package:google_fonts/google_fonts.dart';
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

  String separateIntoParagraphs(String text) {
    List<String> paragraphs = text
        .split('. '); // Assuming paragraphs are separated by a dot and a space
    String result = '';

    for (String paragraph in paragraphs) {
      result += '$paragraph.\n\n'; // Add two line breaks after each paragraph
    }

    return result.trim(); // Trim any leading or trailing whitespace
  }

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
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.play(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      picture.copyright != null
                          ? Text(
                              picture.copyright.toString(),
                              style: GoogleFonts.shareTechMono(
                                  fontSize: 16, color: Colors.white),
                            )
                          : Text(
                              'NASA',
                              style: GoogleFonts.shareTechMono(
                                  fontSize: 16, color: Colors.white),
                            ),
                      if (picture.type == "video")
                        YoutubePlayer(controller: controller)
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
                        separateIntoParagraphs(picture.explanation),
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.inter(color: Colors.white),
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
