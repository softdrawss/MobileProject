import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_project/models/apod.dart';

class APODScreen extends StatefulWidget {
  const APODScreen({super.key});

  @override
  State<APODScreen> createState() => _APODScreenState();
}

class _APODScreenState extends State<APODScreen> {
  DateTime dateTime = DateTime.now();

  void selectDate() {
    showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Color.fromARGB(
                        255, 80, 54, 116), // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface:
                        Color.fromARGB(255, 161, 175, 188), // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1995, 6, 20),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        dateTime = value!;
      });
    });
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
                      if (picture.type == "video")
                        Text(
                          picture.url,
                          style: const TextStyle(color: Colors.blue),
                        )
                      else
                        Image(image: NetworkImage(picture.url)),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          selectDate();
                        },
                        child: Text(
                          dateTime.toString().split(" ")[0],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 161, 175, 188)),
                        ),
                      ),
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
