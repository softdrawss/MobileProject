import 'package:flutter/material.dart';
import 'package:mobile_project/models/epic.dart';

class EarthViewScreen extends StatelessWidget {
  const EarthViewScreen({super.key});

  //final String date = "2024-01-13";
  final String date = "2015-06-13";
  final int currentImg = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadEPICData(date),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final epic = snapshot.data!;

          return Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
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
                    Text(epic[currentImg].date.substring(0, 10)),
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
                ),
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
                            const Text("Latitude:           ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                            Text(epic[currentImg].lat.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Longitude:        ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                            Text(epic[currentImg].lon.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("DSCOVR position:    ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(epic[currentImg].dscovrX.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].dscovrY.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].dscovrZ.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Moon position:    ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(epic[currentImg].lunarX.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].lunarY.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].lunarZ.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Sun position:    ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 20, 44))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(epic[currentImg].sunX.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].sunY.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].sunZ.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 20, 44))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NumberSlider extends StatefulWidget {
  const NumberSlider({super.key, this.maxValue = 0});

  final int maxValue;

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
          max: widget.maxValue.toDouble(),
          divisions: widget.maxValue,
          onChanged: (newValue) {
            setState(() {
              number = newValue; // <---- set new value
            });
          },
        ),
      ],
    );
  }
}
