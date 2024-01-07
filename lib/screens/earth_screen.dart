import 'package:flutter/material.dart';
import 'package:mobile_project/models/epic.dart';

import '../widgets/apod_choose_date_widget.dart';

class EarthViewScreen extends StatefulWidget {
  const EarthViewScreen({super.key});

  @override
  State<EarthViewScreen> createState() => _EarthViewScreenState();
}

class _EarthViewScreenState extends State<EarthViewScreen> {
  DateTime date = DateTime.now();
  //String date = "2015-06-13";
  int currentImg = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadEPICData(date.toString().split(" ")[0]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final epic = snapshot.data!;

          if (epic.isNotEmpty) {
            return Center(
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                      child: Image(
                        image: NetworkImage(epic[currentImg].image),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(epic[currentImg].caption,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Date: "),
                      ChooseDateWidget(
                          dateTime: date,
                          beginDate: DateTime(2015, 6, 13),
                          onDateChanged: (newDateTime) {
                            setState(() {
                              date = newDateTime;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Time: "),
                      Text(epic[currentImg].date.substring(11)),
                    ],
                  ),
                  NumberSlider(
                      maxValue: epic.length,
                      position: (newPosition) {
                        setState(() {
                          currentImg = newPosition.toInt();
                        });
                      }),
                  Container(
                    height: 130,
                    margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 161, 175, 188),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                "Latitude:",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44)),
                              ),
                              const SizedBox(width: 15),
                              Text(epic[currentImg].lat.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 30, 20, 44))),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Longitude:",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44)),
                              ),
                              const SizedBox(width: 15),
                              Text(epic[currentImg].lon.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 30, 20, 44))),
                            ],
                          ),
                          XYZPositions(
                              object: "DSCOVR",
                              x: epic[currentImg].dscovrX.toString(),
                              y: epic[currentImg].dscovrY.toString(),
                              z: epic[currentImg].dscovrZ.toString()),
                          XYZPositions(
                              object: "Moon",
                              x: epic[currentImg].lunarX.toString(),
                              y: epic[currentImg].lunarY.toString(),
                              z: epic[currentImg].lunarZ.toString()),
                          XYZPositions(
                              object: "Sun",
                              x: epic[currentImg].sunX.toString(),
                              y: epic[currentImg].sunY.toString(),
                              z: epic[currentImg].sunZ.toString()),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
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
                  const Spacer(),
                  const Text(
                    "No data available for this date",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Date: "),
                      ChooseDateWidget(
                          dateTime: date,
                          beginDate: DateTime(2015, 6, 13),
                          onDateChanged: (newDateTime) {
                            setState(() {
                              date = newDateTime;
                            });
                          }),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class XYZPositions extends StatelessWidget {
  const XYZPositions({
    super.key,
    required this.object,
    required this.x,
    required this.y,
    required this.z,
  });

  final String object, x, y, z;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$object position:",
          style: const TextStyle(color: Color.fromARGB(255, 30, 20, 44)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(x,
                style: const TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
            Text(y,
                style: const TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
            Text(z,
                style: const TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
          ],
        ),
      ],
    );
  }
}

class NumberSlider extends StatefulWidget {
  const NumberSlider(
      {super.key, required this.maxValue, required this.position});

  final int maxValue;
  final Function(double) position;

  @override
  State<NumberSlider> createState() => _NumberSliderState();
}

class _NumberSliderState extends State<NumberSlider> {
  double number = 0.0; // <---- store the value

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: number, // <---- show the value
          min: 0,
          max: widget.maxValue.toDouble() - 1,
          divisions: widget.maxValue - 1,
          onChanged: (newValue) {
            setState(() {
              number = newValue; // <---- set new value
              widget.position(number);
            });
          },
        ),
      ],
    );
  }
}
