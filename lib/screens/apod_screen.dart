import 'package:flutter/material.dart';
import 'package:mobile_project/models/apod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../widgets/apod_choose_date_widget.dart';

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
                  //This widget displays all the screen info from API depending on the date
                  APODInfoWidget(
                    picture: picture,
                    controller: controller,
                    dateTime: dateTime,
                    onDateChanged: (newDateTime) {
                      //Pass a function that changes a value: In this case a DateTime
                      setState(() {
                        dateTime = newDateTime;
                      });
                    },
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

class APODInfoWidget extends StatefulWidget {
  const APODInfoWidget({
    super.key,
    required this.picture,
    required this.controller,
    required this.dateTime,
    required this.onDateChanged,
  });

  final APOD picture;
  final YoutubePlayerController controller;
  final DateTime dateTime;
  final Function(DateTime) onDateChanged;

  @override
  State<APODInfoWidget> createState() => _APODInfoWidgetState();
}

class _APODInfoWidgetState extends State<APODInfoWidget> {
  //Function that separates a text into paragraphs
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
    return Column(
      children: [
        Text(widget.picture.title,
            textAlign: TextAlign.justify, style: titleStyle),
        widget.picture.copyright != null
            ? Text(widget.picture.copyright.toString(), style: autorStyle)
            : Text('NASA', style: autorStyle),
        widget.picture.type == "video"
            ? YoutubePlayer(controller: widget.controller)
            : Image(image: NetworkImage(widget.picture.url)),
        const SizedBox(height: 15),
        ChooseDateWidget(
            dateTime: widget.dateTime,
            beginDate: DateTime(1995, 6, 20),
            onDateChanged: (newDateTime) {
              setState(() {
                widget.onDateChanged(newDateTime);
              });
            }),
        const SizedBox(height: 15),
        Text(separateIntoParagraphs(widget.picture.explanation),
            textAlign: TextAlign.justify, style: infoStyle),
      ],
    );
  }
}
