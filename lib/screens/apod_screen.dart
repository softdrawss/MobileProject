import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_project/models/apod.dart';

class APODScreen extends StatefulWidget {
  const APODScreen({super.key});

  @override
  State<APODScreen> createState() => _APODScreenState();
}

class _APODScreenState extends State<APODScreen> {
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: loadAPOD(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final picture = snapshot.data!;
          return Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.05, 0, screenWidth * 0.05, 0),
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
                          style: const TextStyle(color: Colors.white),
                        ),
                        Image(
                          image: picture.type == "image"
                              ? NetworkImage(picture.url)
                              : NetworkImage(picture.thumbs!),
                        ),
                        if (picture.type == "video") Text(picture.url),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: picture.date,
                            filled: true,
                            prefixIcon: const Icon(Icons.calendar_today),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          readOnly: true,
                          onTap: () {
                            selectDate();
                          },
                        ),
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
            ),
          );
        },
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995, 6, 20),
        lastDate: DateTime.now());
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
